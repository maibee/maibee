class Transfer < ApplicationRecord
  belongs_to :currency
  validates :amount, numericality: { greater_than: 0 }

  def generate_num
    (Digest::SHA1.hexdigest("#{last_num}#{self.user_id}#{self.amount}"))[0..10]
  end
  def last_num
    return 'last' unless Transfer.last
    Transfer.last.num
  end
end
