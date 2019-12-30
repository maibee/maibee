class TransfersController < ApplicationController
  layout 'user_menu',except: [:new]
  require 'block_io'

  def index
    @transfers = current_user.transfers
  end

  def show
    @transfer = current_user.transfers.find_by(id: params[:id])
  end
  
  def create
    @transfer = Transfer.new(transfer_params)
    @transfer.user_id = current_user.id
    @transfer.num = @transfer.generate_num
    if @transfer.save
      # transfer(@transfer.amount, @transfer.target)
      redirect_to transfers_path
    else
      render :new
    end
  end
  
  def new
    @currencies = Currency.all.map{|c| [c.name, c.id] }
    @transfer = Transfer.new
  end

  private

  def transfer_params
    params.require(:transfer).permit(:amount, :target, :currency_id)

  end
  
  def transfer(amounts, target)
    BlockIo.set_options :api_key=> ENV["DOGECOIN"],
                        :pin => ENV["PIN"], :version => 2
    BlockIo.withdraw :amounts => amount, 
                     :to_addresses => target
  end

end

