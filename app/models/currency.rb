class Currency < ApplicationRecord
  scope :tradable, ->{where({name: ["Bitcoin", "Litecoin", "炒作幣", "Dogecoin"]})}
  extend FriendlyId
  friendly_id :codename, use: :slugged
  has_many :latest_prices

  def last_rate
    self.latest.price
  end

  def latest
    return honey_point_price if self.codename == 'HP'
    return spq_price if self.codename == 'SPQ'
    unless self.latest_prices.last
      update_price
    else
      if (self.latest_prices.last.created_at + 60*60) < Time.now
        update_price
      end
    end
    self.latest_prices.last
  end

  def update_price
    query = PriceQuery.new([
      Currency.find_by(codename: 'BTC'),
      Currency.find_by(codename: 'LTC'),
      Currency.find_by(codename: 'DOGE')
    ])
    query.get_price
  end

  def honey_point_price
    if self.latest_prices.last == nil
      self.latest_prices.create(price: 1)
    end
    self.latest_prices.last
  end

  def spq_price
    if self.latest_prices.last == nil
      self.latest_prices.create(price: 50)
    end
    self.latest_prices.last
  end
end
