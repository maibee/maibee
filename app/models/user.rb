class User < ApplicationRecord
  include AASM
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  #驗證
  # validates :last_name, presence: true
  # validates :first_name, presence: true

  # before_save do
  #   if self.wallet_id == nil
  #     wallet = Wallet.create
  #     self.wallet_id = wallet.id
  #   end
  # end
  has_many :wallets
  has_many :records

  has_many :transfers
  has_many :limit_orders
  has_many :transaction_records

  def make_limit_order(order_content)
    my_wallet = self.wallets.where(currency_id: order_content.currency_id)
    if my_wallet.amount >= order_content.price
       self.limit_orders.build(currency: order_content.currency_id,
                               amount: order_content.amount,
                               status: pending,
                               sell_price: order_content.sell_price)
       my_wallet.amount -= order_content.amount
       my_wallet.save
    else
      redirect_to root_path, notice: ["餘額不足"]
    end
  end

  def bit_limit_order(limit_order)
    # my_wallet = self.wallets.where(currency_id: limit_order.currency_id)
    # if my_wallet.amount >= limit_order.price
    #   self.wallet
  end
end
