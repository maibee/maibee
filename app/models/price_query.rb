class PriceQuery
  def initialize(currencies)
    @codename = currencies.map{|c| c.codename}.join(',').upcase
    @currencies = currencies
  end

  def get_price
    info = get_price_from_cmc['data']
    @currencies.each do |currency|
      quote = info[currency.codename]['quote']['TWD']
      currency.latest_prices.create(
        price: quote['price'],
        volume_24h: quote['volume_24h'],
        percent_change_1h: quote['percent_change_1h'],
        percent_change_24h: quote['percent_change_24h'],
        percent_change_7d: quote['percent_change_7d']
      )
    end
  end

  private

  def get_price_from_cmc
    HTTParty.get("https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest?convert=TWD&CMC_PRO_API_KEY=#{ENV['cmc_key']}&symbol=#{@codename}")
  end

end
