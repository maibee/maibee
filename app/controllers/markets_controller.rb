class MarketsController < ApplicationController
  
  before_action :authenticate_user! 

  def index
    @limit_orders = LimitOrder.pending
  end

  def new
    @currencies = Currency.tradable.map{|c| [c.name, c.id] }
  end

  def create
    order_content = {currency_id: params[:currency_id].to_i, amount: params[:amount].to_f, sell_price: params[:sell_price].to_f}
    if current_user.make_limit_order(order_content) 
      redirect_to markets_path
    else
      render :new, notice: 'Please check your balance'
    end 
  end

  def show
    @limit_orders = LimitOrder.where(user_id: current_user.id).pending
    @limit_orders_cancelled = LimitOrder.where(user_id: current_user.id).cancelled
    @limit_orders_deal = LimitOrder.where(user_id: current_user.id).closed_deal
  end

  def edit
    @limit_order = LimitOrder.find(params[:id])
    if
      current_user.cancel_limit_order(@limit_order)
      redirect_to market_path, notice: 'Order cancelled!'
    end
  end

  def bit
    @limit_order = LimitOrder.find(params[:id])
    if current_user.bit_limit_order(@limit_order)
    redirect_to market_path, notice: 'Succeed'
    else
      redirect_to markets_path, notice: 'HONEYCOIN not enough'
    end
  end
end
