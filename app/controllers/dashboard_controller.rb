class DashboardController < ApplicationController
  def index
    GetCurrencyJob.perform_later
    @currencies = Currency.all
  end

  def career
  end

  def legal

  end
  def language

  end
  def help

  end
end
