class OrdersController < ApplicationController
  layout 'user_menu'
  require 'digest'
  def index
    @orders = Order.where(user_id: current_user)
  end
  def show
    @order = Order.find(params[:id])
  end
  def pay
    @order = Order.find(params[:id])
    if @order.save
      wallet = Wallet.find_or_create(@order, current_user)
      wallet.amount ||= 0
      wallet.amount += (@order.amount)
      wallet.save
      @order.pay!
    end
    redirect_to order_path(@order)
  end

  def create
    @order = Order.new(order_params)
    @order.user_id = current_user.id
    @order.price = Currency.find_by(id: @order.currency_id).last_rate
    @order.number = @order.generate_order_number
    if @order.save
      create_unread_record
      redirect_to order_path(@order), notice: 'Order Created'
    else
      render 'exchanges/show', notice: 'Something went wrong'
    end
  end

  private
  def order_params
    params.require(:order).permit(:amount, :currency_id)
  end
  def last_order_number
    return '' unless Order.last
    Order.last.number
  end

  def create_unread_record
    current_user.records.create(content: "Order Created")
    current_user.unread += 1
    current_user.save
  end
end
