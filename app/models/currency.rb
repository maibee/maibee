class Currency < ApplicationRecord
  scope :tradable, ->{where.not(name: "HONEYCOIN")}
end
