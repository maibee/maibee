class Order < ApplicationRecord
  belongs_to :currency
  belongs_to :user
  enum status: [:unpaid, :finished, :expired, :canceled]
  before_save do
    self.status ||= 0
  end

end
