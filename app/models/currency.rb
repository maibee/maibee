class Currency < ApplicationRecord
  scope :tradable, ->{where.not(name: "HoneyPoint")}
  extend FriendlyId
  friendly_id :codename, use: :slugged
  has_many :latest_prices
end
