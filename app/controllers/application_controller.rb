class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :records

  private

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
    redirect_to confirmation_letters_path if current_user == 'uncertified'
  end
end
