class ExchangesController < ApplicationController
  
  before_action :authenticate_user!

  def index
    @currencies = Currency.tradable
  end
  
  def show
    @currency = Currency.friendly.find((params[:id]).downcase)
    @order = Order.new(currency_id: @currency.id)
    @currencies = Currency.tradable.map{|c| [c.name, c.id] }
    @amount = get_wallet ? get_wallet.amount : 0
  end

  def sell
    @currency = Currency.friendly.find((params[:id]).downcase)
    @order = Order.new(currency_id: @currency.id)
    @currencies = Currency.tradable.map{|c| [c.name, c.id] }
    @amount = get_wallet ? get_wallet.amount : 0
  end

  private

  def get_wallet
    current_user.wallets.where(currency_id: @currency.id).first
  end
end
