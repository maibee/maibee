class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :records #for notifications on header
  before_action :demo_rank #for DemoDay event only

  private

  def demo_rank
    @rank = Wallet.all
                  .map{|w| [w.user_id, (w.amount * get_rate(w.currency_id))]}
                  .sort{|x,y| x[0] <=> y[0]}
                  .reduce([[]]){|accu, w| (accu[-1][0] == w[0]) ? accu[0..-2].push([w[0],(accu[-1][1] + w[1])]) : accu.push(w)}[1..]
                  .sort{|x,y| x[1] <=> y[1]}
                  .last(10)
                  .reverse
  end

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
