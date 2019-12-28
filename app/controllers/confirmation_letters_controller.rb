class ConfirmationLettersController < ApplicationController
  
  require 'securerandom'

  def index
  end

  def edit
    # ConfirmationMailer.confirmation_letter(current_user).deliver
    @checknum = SecureRandom.hex(6)
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
