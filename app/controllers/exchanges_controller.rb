class ExchangesController < ApplicationController
  def index
    
    @currencies = Currency.tradable
  end
  def show
    active?
    @currency = Currency.find_by(id: params[:id])
    @order = Order.new
    @currencies = Currency.tradable.map{|c| [c.name, c.id] }
  end

  private
  def active?
    
    if current_user.status == false
      redirect_to confirmation_letters_path
    end
  end

end
