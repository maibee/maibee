class DashboardController < ApplicationController
  def index
    @currencies = Currency.tradable
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
