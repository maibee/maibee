class ConfirmationLettersController < ApplicationController
  def edit
    #update varification colum
    # ConfirmationMailer.confirmation_letter(current_user.email).deliver
    @user = current_user
  end

  def update
    @user = User.find_by(id: params[:id])
    if params[:user][:first_name] == @user.first_name
      @user.update(status: true)
      redirect_to root_path, notice: "Activated!!"
    else
      render :edit, notice: "try again"
    end
  end
end
