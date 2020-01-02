class WalletsController < ApplicationController
  def index
    @wallets = Wallet.where(user_id: current_user.id)
    @currencies = Currency.all
  end
end
