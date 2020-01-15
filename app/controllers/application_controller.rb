class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :records #for notifications on header
<<<<<<< HEAD
  before_action :demo_rank #for DemoDay event only
  before_action :set_locale
=======
>>>>>>> setup demo event page WIP

  def set_locale
    # 可以將 ["en", "zh-TW"] 設定為 VALID_LANG 放到 config/environment.rb 中
    if params[:locale] && I18n.available_locales.include?( params[:locale].to_sym )
      session[:locale] = params[:locale]
    end

    I18n.locale = session[:locale] || I18n.default_locale
  end
  private


  def get_rate(currency_id)
    Currency.find_by(id: currency_id).last_rate
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end

  def records
    @records = current_user.records.last(10).reverse if current_user
  end

  def show_menu
    @show_menu = true
  end

  def check_user_state
    authenticate_user!
    redirect_to confirmation_letters_path if current_user.state == 'uncertified'
  end
end
