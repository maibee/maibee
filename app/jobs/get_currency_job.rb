class GetCurrencyJob < ApplicationJob
  queue_as :default
  require 'block_io'
  def perform
    # Do something later
    ["Dogecoin", "Litecoin", "Bitcoin"].each do |name|
      BlockIo.set_options :api_key=> ENV[name], :pin => ENV["PIN"], :version => 2
      outsite_coin_currency = BlockIo.get_current_price["data"]["prices"][0]["price"].to_f*21
      if Currency.find_by(name: name) 
        Currency.find_by(name: name).update(last_rate: outsite_coin_currency)
      else
        Currency.create(name: name,last_rate: outsite_coin_currency)
      end
    end
  end
end
