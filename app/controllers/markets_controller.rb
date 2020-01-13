class MarketsController < ApplicationController
  
  before_action :check_user_state

  def index
    @limit_orders_selling = LimitOrder.pending.reverse
    @currencies = Currency.tradable
    @limit_orders = LimitOrder.where(user_id: current_user.id).pending.reverse
    @limit_orders_cancelled = LimitOrder.where(user_id: current_user.id).cancelled.reverse
    @limit_orders_deal = LimitOrder.where(user_id: current_user.id).closed_deal.reverse
    @account_balance = Wallet.where(user_id: current_user.id)
    @currencies_to_trade = Currency.tradable.map{|c| [c.name, c.id] }
  end

  def new
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
      redirect_to markets_path
    else
      redirect_to new_market_path, notice: '*Please check your balance or input value'
    end 
  end

  def show
  end

  def edit
    @limit_order = LimitOrder.find(params[:id])
    if current_user.cancel_limit_order(@limit_order)
      ActionCable.server.broadcast 'remove_channel', content: @limit_order
      redirect_to markets_path, notice: 'Order cancelled!'
    end
  end

  def bit
    @limit_order = LimitOrder.find(params[:id])
    if current_user.bit_limit_order(@limit_order)
      ActionCable.server.broadcast 'remove_channel', content: @limit_order
      redirect_to market_path, notice: 'Succeed'
    else
      redirect_to markets_path, notice: 'HoneyPoints not enough'
    end
  end

  private
  def create_unread_record(order)
    current_user.records.create(content: "#{Currency.find_by(id: order.currency_id).name} limit order created", order_type: 'limit order')
    current_user.unread += 1
    current_user.save
  end
end
