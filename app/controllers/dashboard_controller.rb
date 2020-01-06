class DashboardController < ApplicationController
  def index
    @currencies = Currency.tradable
    @wallets = current_user.wallets
    @orders = current_user.orders
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
