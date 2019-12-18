class DashboardController < ApplicationController
  def index
    @currencies = Currency.all

  end
end
