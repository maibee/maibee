class MarketsController < ApplicationController
  
  before_action :check_user_state

  def index
    @demo_currency = Currency.find_by(name: "炒作幣")
    @limit_orders_selling = LimitOrder.pending.reverse
    @currencies = Currency.tradable
    @limit_orders = LimitOrder.where(user_id: current_user.id)
    @account_balance = Wallet.where(user_id: current_user.id)
    @currencies_to_trade = Currency.tradable.map{|c| [c.name, c.id] }
    @wallets = current_user.wallets.reduce({}) do |rs, wallet|
      rs[wallet.currency_id] = wallet.amount
      rs
    end
    # @first = current_user.wallets.find_by(currency_id: (Currency.tradable.first.id)).amount
  end

  def new
    # @wallets = current_user.wallets.map{|w| {w.currency_id=> w.amount}}
    @wallets = current_user.wallets.reduce({}) do |rs, wallet|
      rs[wallet.currency_id] = wallet.amount
      rs
    end
    @currencies_to_trade = Currency.tradable.map{|c| [c.name, c.id] }
    @account_balance = Wallet.where(user_id: current_user.id)
  end

  def create
    @currencies = Currency.tradable.map{|c| [c.name, c.id] }
    order_content = {currency_id: params[:currency_id].to_i, amount: params[:amount].to_f, sell_price: params[:sell_price].to_f}
    if current_user.make_limit_order(order_content)
      @order_currency = LimitOrder.last.currency[:name]
      ActionCable.server.broadcast 'room_channel', content: [LimitOrder.last, @order_currency, LimitOrder.last.price]
      create_unread_record(LimitOrder.last) 
      redirect_to markets_path, notice: I18n.t(:limit_order_create_successfully)
    else
      redirect_to new_market_path, notice: I18n.t(:please_check_your_balance_or_input_value)
    end 
  end

  def edit
    @limit_order = LimitOrder.find(params[:id])
    if current_user.cancel_limit_order(@limit_order)
      ActionCable.server.broadcast 'cancel_channel', content: @limit_order
      redirect_to markets_path, notice: I18n.t(:order_cancelled!)
    end
  end

  def bit
    @limit_order = LimitOrder.find(params[:id])
    if current_user.bit_limit_order(@limit_order)
      ActionCable.server.broadcast 'remove_channel', content: @limit_order
      redirect_to markets_path, notice: I18n.t(:bit_successfully)
    else
      redirect_to markets_path, notice: I18n.t(:dont_have_enough_honey_point)
    end
  end

  private
  def create_unread_record(order)
    current_user.records.create(content: "#{Currency.find_by(id: order.currency_id).name} limit order created", order_type: 'limit order')
    current_user.unread += 1
    current_user.save
  end
end
