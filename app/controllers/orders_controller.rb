class OrdersController < ApplicationController
  before_action :show_menu, only: [:index]

  def index
    @orders = Order.where(user_id: current_user)
  end

  def show
    @order = Order.friendly.find(params[:id])
  end

  def pay
    @order = Order.friendly.find(params[:id])
    honey_point = current_user.honey_point
    wallet = Wallet.find_or_create(@order, current_user)
    wallet.amount ||= 0
    if @order.is_sell
      honey_point.amount += (@order.amount * @order.price)
      wallet.amount -= (@order.amount)
    else
      if current_user.balance < (@order.amount * @order.price)
        redirect_to order_path(@order), notice: 'Dont have enough honey point'
      end
      honey_point.amount -= (@order.amount * @order.price)
      wallet.amount += (@order.amount)
    end
    if honey_point.save && wallet.save
      @order.pay!
      if @order.currency.codename == 'SPQ'
        spq = @order.currency
        unless @order.is_sell
          spq.latest_prices.create(price: (spq.latest_prices.last.price * 1.1))
        else
          spq.latest_prices.create(price: (spq.latest_prices.last.price * 0.85))
        end
        spq.save
      end
      redirect_to order_path(@order), notice: 'order completed'
    end
  end

  def create
    @order = Order.new(order_params)
    @order.user_id = current_user.id
    @order.price = Currency.find_by(id: @order.currency_id).last_rate
    @order.number = @order.generate_order_number
    my_wallet = Wallet.find_by(user_id: current_user.id, currency_id: @order.currency_id)
    if @order.is_sell == true
      if @order.amount <= my_wallet.amount && @order.save
      create_unread_record(@order)
      redirect_to order_path(@order), notice: 'Order Created'
      else
        render 'exchanges/sell', notice: 'Something went wrong'
      end
    else
      if @order.save
        create_unread_record(@order)
        redirect_to order_path(@order), notice: 'Order Created'
      else
        render 'exchanges/show', notice: 'Something went wrong'
      end
    end
  end

  private

  def order_params
    params.require(:order).permit(:amount, :currency_id, :is_sell)
  end

  def last_order_number
    return '' unless Order.last
    Order.last.number
  end

  def create_unread_record(order)
    current_user.records.create(content: "#{order.amount} #{Currency.find_by(id: order.currency_id).name}s purchased", order_type: 'order')
    current_user.unread += 1
    current_user.save
  end
end
