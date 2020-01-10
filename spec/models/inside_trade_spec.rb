require 'rails_helper'

RSpec.describe User do
  context "掛賣功能" do 
    it "可以知道這單虛擬貨幣賣多少錢" do
      limit_order = LimitOrder.create(amount: '2', sell_price: '1.5')
      limit_order.currency= Currency.first
      limit_order.user= User.last
      limit_order.save

      expect(limit_order.price).to eq 3
    end
    it "使用者可以掛賣，並同時建立賣單" do
      c2 = Currency.create(name: 'HoneyPoint')
      u1 = FactoryBot.create(:user, password: "1111111", password_confirmation: "1111111")
      c1 = FactoryBot.create(:currency)
      w1 = u1.wallets.create(currency_id: c1.id, amount: 50)
      
      order_content = {
        "amount": 5,
        "sell_price": 1.5,
        "currency_id": c1.id
      }
      
      u1.make_limit_order(order_content)
      expect(u1.wallets.find_by(currency_id: order_content[:currency_id])[:amount]).to eq 45
      expect(LimitOrder.find_by(user_id: u1.id).price).to eq 7.5
    end
    it "使用者將某個幣別的存款轉帳給其他用戶" do 
      c2 = Currency.create(name: 'HoneyPoint')
      u1 = FactoryBot.create(:user, password: "1111111", password_confirmation: "1111111")
      u2 = FactoryBot.create(:user, password: "2222222", password_confirmation: "2222222")
      c1 = FactoryBot.create(:currency)
      w1 = u1.wallets.create(currency_id: c1.id, amount: 50)
      
      w2 = u2.wallets.create(currency_id: c1.id, amount: 50)
      
      u1.remit(u2, c1, 50)
      
      expect(u1.wallets.find_by(currency_id: c1.id)[:amount]).to eq 0
      expect(u2.wallets.find_by(currency_id: c1.id)[:amount]).to eq 100
    end
    it "取消掛單(蓋單貨幣會退回帳戶）" do
      c2 = Currency.create(name: 'HoneyPoint')
      u1 = FactoryBot.create(:user, password: "1111111", password_confirmation: "1111111")
      c1 = FactoryBot.create(:currency)
      w1 = u1.wallets.create(currency_id: c1.id, amount: 50)
      
      order_content = {
        "amount": 5,
        "sell_price": 1.5,
        "currency_id": c1.id
      }
      u1.make_limit_order(order_content)
      o1 = LimitOrder.find_by(user_id: u1.id, currency_id: c1)

      u1.cancel_limit_order(o1)
      expect(LimitOrder.find_by(user_id: u1.id)[:status]).to eq "cancelled"
      expect(u1.wallets.find_by(currency_id: o1.currency_id).amount).to eq 50
    end
    it "使用者買單時，帳戶內該幣別會增加，而且新台幣帳戶會轉帳過去" do 
      honey_coin = Currency.create(name: "HoneyPoint")
      u1 = FactoryBot.create(:user, password: "1111111", password_confirmation: "1111111")
      u2 = FactoryBot.create(:user, password: "2222222", password_confirmation: "2222222")
      c1 = FactoryBot.create(:currency)
      w1 = u1.wallets.create(currency_id: c1.id, amount: 50)
      w2 = u2.wallets.create(currency_id: c1.id, amount: 50)
      honey_coin_wallet1 = Wallet.find_by(currency_id: honey_coin.id,user_id: u1.id)
      honey_coin_wallet2 = Wallet.find_by(currency_id: honey_coin.id,user_id: u2.id)
      honey_coin_wallet1.update(amount: 100)
      honey_coin_wallet2.update(amount: 100)
      order_content = {
        "amount": 5,
        "sell_price": 1.5,
        "currency_id": c1.id
      }
      u1.make_limit_order(order_content)

      target_order = LimitOrder.find_by(amount: 5, currency_id: c1.id, sell_price: 1.5)
      u2.bit_limit_order(target_order)
      
      expect(u1.wallets.find_by(currency_id: c1.id).amount).to eq 45
      expect(u1.wallets.find_by(currency_id: honey_coin_wallet1.currency_id).amount).to eq 107.5
      expect(u2.wallets.find_by(currency_id: c1.id).amount).to eq 55
      expect(u2.wallets.find_by(currency_id: honey_coin_wallet2.currency_id).amount).to eq 92.5
    end
  end
end

