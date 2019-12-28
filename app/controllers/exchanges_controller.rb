class ExchangesController < ApplicationController
  before_action :active?
  def index
    
    @currencies = Currency.all
  end
  def show
    @currency = Currency.find_by(id: params[:id])
    @order = Order.new
    @currencies = Currency.all.map{|c| [c.name, c.id] }
  end

  private
  def active?
    if current_user.status == false
      redirect_to confirmation_letters_path(current_user)
    end
  end

end
