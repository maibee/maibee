class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :records #for notifications on header

  def demo_rank
    Wallet.all.map{|w| [w.user_id, (w.amount * get_rate(w.currency_id))]}
      .reduce([[]]){|accu, w| accu[0] == w[0] ? }
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
end
