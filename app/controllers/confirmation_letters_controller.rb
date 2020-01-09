class ConfirmationLettersController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user 
  end

  def upgrade
    @user = current_user
    if  (params["first_name"] =~ /^[A-Z|a-z]+$/) != nil && (params["last_name"] =~ /^[A-Z|a-z]+$/) != nil
    @user.update(first_name: params["first_name"], last_name: params["last_name"])
    redirect_to edit_confirmation_letter_path(@user)
    else
      render :index, notice: "Unacceptble input"
    end
  end

  def edit
    @checknum = SecureRandom.hex(6)
    # ConfirmEmailJob.perform(current_user)
  end

  def update
    @user = User.find_by(id: params[:id])
    if params
      @user.update(state: 'basic')
      redirect_to root_path, notice: "Activated!!"
    else
      render :edit, notice: "try again"
    end
  end
end
