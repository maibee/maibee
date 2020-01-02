class TransfersController < ApplicationController
  require 'block_io'

  def index
    show_menu
    @transfers = current_user.transfers
  end

  def show
    @transfer = current_user.transfers.find_by(id: params[:id])
  end
  
  def create
    @currencies = Currency.tradable
    @transfer = Transfer.new(transfer_params)
    if @transfer.amount > current_user.wallets.find_by(currency_id: @transfer.currency_id).amount
      flash[:notice] = "Post successfully created"
      render :new, notice: "You don\'t have enough #{@transfer.currency.name}"
    else
      @transfer.user_id = current_user.id
      @transfer.num = @transfer.generate_num
      if @transfer.save
        TransferJob.perform_later(@transfer)
        redirect_to transfers_path
      else
        render :new
      end
    end
  end
  
  def new
    @currencies = Currency.tradable.map{|c| [c.name, c.id] }
    @transfer = Transfer.new
  end

  private

  def transfer_params
    params.require(:transfer).permit(:amount, :target, :currency_id)
  end
end

