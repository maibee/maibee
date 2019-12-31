class LimitOrder < ApplicationRecord
  include AASM
  
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
