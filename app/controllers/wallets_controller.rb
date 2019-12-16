class WalletsController < ApplicationController
  def show
    @wallet = Wallet.first || Wallet.create(ntd: 1000,xpr: 50, honey: 3.555)
    # use a fake one before user model is setted
    
  end
end
