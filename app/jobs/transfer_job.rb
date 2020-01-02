class TransferJob < ApplicationJob
  queue_as :default

  def perform(transfer)
    BlockIo.set_options :api_key=> ENV[transfer.currency.name], :pin => ENV["pin"], :version => 2
    BlockIo.withdraw :amounts => transfer.amounts.to_s, :to_addresses => transfer.target
    transfer.txid = (BlockIo.get_transactions :type => 'sent')["data"]["txs"][0]["txid"]
    transfer.save
  end
end
