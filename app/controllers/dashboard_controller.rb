class DashboardController < ApplicationController
  def index
    GetCurrencyJob.perform_later
    @currencies = Currency.all
  end

  def member

  end
  def permit

  end
end
