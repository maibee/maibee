class WalletsController < ApplicationController
  def index
    @wallets = Wallet.where(user: current_user)
    @currencies = Currency.all
    @records = Record.where(user_id: current_user.id)
  end
end
