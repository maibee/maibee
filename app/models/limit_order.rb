class LimitOrder < ApplicationRecord
  include AASM
  
  validates :amount, :sell_price, numericality: { greater_than: 0 }

  belongs_to :user
  belongs_to :currency

  before_create :generate_num

  def price
     self.amount * self.sell_price
  end

  aasm column: 'status' do
    state :pending, initial: true
    state :closed_deal, :cancelled
  
    event :cancel do
      
      transitions from: :pending, to: :cancelled
    end

    event :deal do

      transitions from: :pending, to: :closed_deal
    end
  end

private
  def generate_num
    self.num = SecureRandom.hex(6)
  end
end

class BigDecimal
  def to_currency
    number_to_currency(self, unit: '$')
  end
end
