class OrdersController < ApplicationController
  def show
  end

  def create
    @order = Order.new(order_params)
    @order.user_id = current_user.id

    wallet = Wallet.find_by(user_id: current_user, currency_id: @order.currency_id) || Wallet.new(user_id: current_user.id, currency_id: @order.currency_id)
    wallet.amount ||= 0
    wallet.amount += (@order.amount)
    wallet.save


    if @order.save
      redirect_to wallets_path, notice: 'Order Created'
    else
      render 'exchanges/show', notice: 'Something went wrong'
    end
  end
  private
  def order_params
    params.require(:order).permit(:amount, :currency_id)
  end
end
