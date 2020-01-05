class DemoController < ApplicationController

  def new
    if Time.now > Time.local(2020,01,19)
      flash[:notice] = "Demo day is over."
      redirect_to root_path
    elsif user_signed_in?
      flash[:notice] = "You already have an account"
      redirect_to root_path
    else
      demo_number = SecureRandom.hex(5)
      demo_user = User.new(email: "#{demo_number}_demo_day@maibee.online", password: demo_number, password_confirmation: demo_number)
      if demo_user.save
        sign_in(demo_user)
        flash[:notice] = "You are now using demo account."
        redirect_to root_path
      else
        flash[:notice] = "Please try again."
        redirect_to root_path
      end
    end
  end

end
