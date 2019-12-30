class GetCurrencyJob < ApplicationJob
  queue_as :default
  require 'block_io'
  def perform
    # Do something later
  BlockIo.set_options :api_key=> ENV["DOGECOIN"], :pin => ENV["PIN"], :version => 2
  dogecoin_currency = BlockIo.get_current_price["data"]["prices"][0]["price"].to_f*20
    if Currency.find_by(name: 'DOGECOIN') 
    Currency.find_by(name: 'DOGECOIN').update(last_rate: dogecoin_currency)
    else
      Currency.create(name: 'DOGECOIN',last_rate: dogecoin_currency)
    end
  end
end
