class HomepageController < ApplicationController
  def index
    @currencies = Currency.all
  end
end
