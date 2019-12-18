class WalletsController < ApplicationController
  def index
    @wallets = Wallet.where(user: current_user)
    @currencies = Currency.all
  end
end
