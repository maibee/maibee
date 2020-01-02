class Wallet < ApplicationRecord
  belongs_to :user
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  belongs_to :currency
  
  def self.find_or_create(order, current_user)
    terms = { user_id: current_user.id, currency_id: order.currency_id }
    self.find_by(terms) || self.new(terms)
  end
end
