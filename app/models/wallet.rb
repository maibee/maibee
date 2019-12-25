class Wallet < ApplicationRecord
  belongs_to :user
  def self.find_or_create(order, current_user)
    terms = { user_id: current_user, currency_id: order.currency_id }
    self.find_by(terms) || self.new(terms)
    
  end






end
