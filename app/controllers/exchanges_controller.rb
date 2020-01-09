class ExchangesController < ApplicationController
  before_action :check_user_state
  
  def index
    @currencies = Currency.tradable
  end
  
  def show
    @currency = Currency.find_by(id: params[:id])
    @order = Order.new
    @currencies = Currency.tradable.map{|c| [c.name, c.id] }
    @amount = get_wallet ? get_wallet.amount : 0
  end

  def sell
    active?
    @currency = Currency.find_by(id: params[:id])
    @order = Order.new
    @currencies = Currency.tradable.map{|c| [c.name, c.id] }
    @amount = get_wallet ? get_wallet.amount : 0
  end

  private

  def get_wallet
    current_user.wallets.where(currency_id: @currency.id).first
  end

  def active?
    if current_user.status == false
      redirect_to confirmation_letters_path
    end
  end
end
