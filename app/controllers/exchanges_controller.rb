class ExchangesController < ApplicationController
  before_action :check_user_state
  def index
    @currencies = Currency.tradable
  end

  def show
    @currency = Currency.find_by(id: params[:id])
    @order = Order.new(currency_id: params[:id])
    @currencies = Currency.tradable.map{ |c| [c.name, c.id] }
    @amount = get_wallet ? get_wallet.amount : 0
  end

  private
  def get_wallet
    current_user.wallets.where(currency_id: @currency.id)[0]
  end
end
