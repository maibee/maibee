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

end
