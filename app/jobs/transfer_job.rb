class TransferJob < ApplicationJob
  queue_as :default

  def perform(amounts, target)
    coin = "DOGECOIN" 
    BlockIo.set_options :api_key=> ENV[coin], :pin => ENV["PIN"], :version => 2
    BlockIo.withdraw :amounts => amounts.to_s, :to_addresses => target
  end
end
