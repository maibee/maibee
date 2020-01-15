class HomepageController < ApplicationController
  def index
    @currencies = Currency.tradable
  end
end
