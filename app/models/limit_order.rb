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
<<<<<<< HEAD
=======

class BigDecimal
  def to_currency
      self - self.ceil + self.ceil.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse.to_f
  end
end
>>>>>>> setup demo event page WIP
