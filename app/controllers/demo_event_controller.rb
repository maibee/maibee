class DemoEventController < ApplicationController
  def index
    @rank = User.where(state: :demo_event)
                .map{|user| [user, user.total_assets]}
                .sort{|x,y| x[1]<=>y[1]}
                .last(10).reverse
  end

  def nickname
    demo_user = current_user
    demo_user.first_name = nickname_params[:first_name]
    demo_user.state = :demo_event
    if demo_user.save
      redirect_to demo_event_path
    else
      render :index
    end
  end

  private

  def get_rate(currency_id)
    Currency.find_by(id: currency_id).last_rate
  end

  def nickname_params
    params.require(:user).permit(:first_name)
  end
end
