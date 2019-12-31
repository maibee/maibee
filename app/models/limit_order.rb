class LimitOrder < ApplicationRecord
  belongs_to :user
  belongs_to :currency

  def price
     self.amount * self.sell_price
  end

  
end
