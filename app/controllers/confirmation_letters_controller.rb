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
      redirect_to confirmation_letters_path, notice: "Unacceptble input"
    end
  end

  def edit
    @checknum = SecureRandom.hex(6)
  end

  def update
    @user = User.find_by(id: params[:id])
    if params[:id].to_i == current_user.id
      @user.update(state: 'basic')
      redirect_to markets_path
    else
      redirect_to confirmation_letters_path, notice: "try again"
    end
  end
end
