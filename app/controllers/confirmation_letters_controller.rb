class ConfirmationLettersController < ApplicationController
  
  require 'securerandom'

  def index
  end

  def edit
    @checknum = SecureRandom.hex(6)
    # ConfirmEmailJob.perform(current_user)
  end

  def update
    @user = User.find_by(id: params[:id])
    if params
      @user.update(status: true)
      redirect_to root_path, notice: "Activated!!"
    else
      render :edit, notice: "try again"
    end
  end
end
