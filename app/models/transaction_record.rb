class TransactionRecord < ApplicationRecord
  belongs_to :limit_order
  belongs_to :user
end
