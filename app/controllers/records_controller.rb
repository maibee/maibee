class RecordsController < ApplicationController
  def update
    current_user.update(unread: 0)
    redirect_to wallets_path
  end
end
