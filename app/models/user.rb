class User < ApplicationRecord
  include AASM
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :wallets
  has_many :records
  has_many :transfers
  has_many :limit_orders
  has_many :transaction_records
  has_many :orders

  enum state: [:uncertified, :basic, :advenced, :removed, :demo]

  after_create do
    if self.state == 'demo'
      self.wallets.create(currency_id: Currency.find_by(codename:"HP").id, amount: 1000000)
    else
      self.wallets.create(currency_id: Currency.find_by(codename:"HP").id, amount: 0)
    end
  end

  def honey_point
    self.wallets.find_by(currency_id: Currency.find_by(codename: 'HP').id)
  end

  def balance
    honey_point.amount
  end

  def make_limit_order(order_content)
    my_wallet = find_wallet(order_content[:currency_id], self.id)

    if ((my_wallet.amount >= order_content[:amount]) &&
       self.limit_orders.create(currency_id: order_content[:currency_id],
                                amount:      order_content[:amount],
                                status:      "pending",
                                sell_price:  order_content[:sell_price]))
       my_wallet.amount -= order_content[:amount]
       my_wallet.save
    end
  end

  def remit(user, currency, amount)
    my_wallet = find_wallet(currency.id, self.id)
    target_wallet = find_wallet(currency.id, user.id)
    
    if my_wallet.amount >= amount
      my_wallet.amount -= amount
      my_wallet.save
      target_wallet.amount += amount
      target_wallet.save
    end
  end

  def cancel_limit_order(limit_order)
    target_order = LimitOrder.find_by(num: limit_order.num)
    if target_order.status == "pending"
      target_order.cancel!
      my_wallet = find_wallet(limit_order.currency_id, self.id)
      my_wallet.amount += limit_order.amount
      my_wallet.save
    end
  end

  def bit_limit_order(limit_order)
    currency = Currency.find(limit_order.currency_id)
    ntd = Currency.find_by(name: "NTD")
    seller = User.find(limit_order.user_id)
    ntd_price = limit_order.price
    
    if self.remit(seller, ntd, ntd_price)
    my_wallet = find_wallet(limit_order.currency_id, self.id)
    my_wallet.amount += limit_order.amount
    my_wallet.save
    limit_order.deal!
    end
  end

  private

  def find_wallet(currency_id, user_id)
    my_wallet = Wallet.find_by(currency_id: currency_id, user_id: user_id)
  end
end
