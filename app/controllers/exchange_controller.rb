class ExchangeController < ApplicationController
  def index
    @currency = Currency.find_by(name: params[:currency])

    
  end

end
