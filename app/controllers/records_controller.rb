class RecordsController < ApplicationController
  def update
    User.find_by(id: current_user.id).update(unread: 0)
    redirect_to wallets_path
  end
end
