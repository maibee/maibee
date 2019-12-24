class Order < ApplicationRecord
  include AASM


  belongs_to :currency
  belongs_to :user

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

end
