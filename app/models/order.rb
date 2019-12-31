class Order < ApplicationRecord
  include AASM
  validates :amount, numericality: { greater_than: 0 }

  before_create :generate_order_number

  belongs_to :currency
  belongs_to :user
  def generate_order_number
    (Digest::SHA1.hexdigest (last_order_number + self.user_id.to_s + self.price.to_s + self.amount.to_s))[0..10]
  end

  aasm :column => 'state' do
    state :unpaid, initial: true
    state :finished, :expired, :canceled

    event :pay do
      transitions from: :unpaid, to: :finished
    end

    event :expire do
      transitions from: :unpaid, to: :expired
    end

    event :cancel do
      transitions from: [:unpaid, :finished, :expired],to: :canceled
    end
  end

  def last_order_number
    return '' unless Order.last
    Order.last.number
  end

end
