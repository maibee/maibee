class HomepageController < ApplicationController
  def index    
    @demo_rank = demo_rank
    @currencies = Currency.tradable
  end
end
