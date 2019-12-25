class OrdersController < ApplicationController
  require 'digest'
  def index
    @orders = Order.where(user_id: current_user)
  end
  def show
    @order = Order.find(params[:id])
  end
  def pay
    @order = Order.find(params[:id])
    @order.status = :finished
    @order.save
    redirect_to order_path(@order)

  end

  def create
    @order = Order.new(order_params)
    @order.user_id = current_user.id
    @order.price = Currency.find_by(id: @order.currency_id).last_rate
    @order.number = (Digest::SHA1.hexdigest (last_order_number + @order.user_id.to_s + @order.price.to_s + @order.amount.to_s))[0..10]

    wallet = Wallet.find_by(user_id: current_user, currency_id: @order.currency_id) || Wallet.new(user_id: current_user.id, currency_id: @order.currency_id)
    wallet.amount ||= 0
    wallet.amount += (@order.amount)
    wallet.save
    if @order.save
      ConfirmationMailer.confirmation_letter(current_user.email).deliver
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
