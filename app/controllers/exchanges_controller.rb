class ExchangesController < ApplicationController
  def index
    
    @currencies = Currency.all
  end
  def show
    @currency = Currency.find_by(id: params[:id])
    @order = Order.new
    @currencies = Currency.all.map{|c| [c.name, c.id] }
  end
end
