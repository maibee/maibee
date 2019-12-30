class HomepageController < ApplicationController
  def index    
    GetCurrencyJob.perform_later
    @currencies = Currency.all
  end
end
