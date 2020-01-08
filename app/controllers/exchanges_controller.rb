class ExchangesController < ApplicationController

  before_action :authenticate_user!

  def index
    
    @currencies = Currency.tradable
  end
  
  def show
    @currency = Currency.find_by(id: params[:id])
    @order = Order.new
    @currencies = Currency.tradable.map{|c| [c.name, c.id] }
  end
end
