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
    @currencies = Currency.all
    @transfer = Transfer.new(transfer_params)
    if @transfer.amount > current_user.wallets.find_by(currency_id: @transfer.currency_id).amount
      p '---------------------------------------'
      render :new, alert: "You don\'t have enough #{@transfer.currency.name}"
      p @transfer.currency.name
      p '---------------------------------------'
    else
      # @transfer.user_id = current_user.id
      # @transfer.num = @transfer.generate_num
      # if @transfer.save
      #   TransferJob.perform_later(@transfer)
      #   redirect_to transfers_path
      # else
      #   render :new
      # end
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

end

