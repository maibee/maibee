class Currency < ApplicationRecord
  scope :tradable, ->{where.not(name: "NTD")}
end
