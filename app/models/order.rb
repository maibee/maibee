class Order < ApplicationRecord
  belongs_to :currency
  belongs_to :user

end
