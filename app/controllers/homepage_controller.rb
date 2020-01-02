class HomepageController < ApplicationController
  def index    
    GetCurrencyJob.perform_later
    @currencies = Currency.tradable
  end
end
