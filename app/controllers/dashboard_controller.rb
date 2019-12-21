class DashboardController < ApplicationController
  def index
    @currencies = Currency.all

  end
  def member

  end
end
