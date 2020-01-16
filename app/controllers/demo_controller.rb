class DemoController < ApplicationController

  def new
    if Time.now > Time.local(2020,01,19)
      flash[:notice] = I18n.t("demo_day_is_over")
      redirect_to root_path
    elsif user_signed_in?
      flash[:notice] = I18n.t("you_already_have_an_account")
      redirect_to root_path
    else
      demo_number = SecureRandom.hex(5)
      demo_user = User.new(email: "#{demo_number}_demo_day@maibee.online", password: demo_number, password_confirmation: demo_number)
      demo_user.state = 'demo'
      if demo_user.save
        sign_in(demo_user)
        flash[:notice] = I18n.t('you_are_now_using_demo_account')
        redirect_to demo_event_path
      else
        flash[:notice] = I18n.t('please_try_again')
        redirect_to root_path
      end
    end
  end

end
