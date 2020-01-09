class HomepageController < ApplicationController
  def index    
    GetCurrencyJob.perform_later
    @demo_rank = demo_rank
    @currencies = Currency.tradable
  end
end
