class Currency < ApplicationRecord
  scope :tradable, ->{where.not(name: "HoneyPoint")}
end
