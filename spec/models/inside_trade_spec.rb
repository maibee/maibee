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
    it "使用者可以掛單" do
      

      order_content = {
        amount: 1,
        sell_price: 1.5,
        currency_id: 1
      }
      
      u1.make_limit_order(order_content)
      
      expect(u1.wallets.where(currency_id: order_content.currency_id).amount).to eq 0
    end
  end
end
# 使用者可以買單
# 使用者將某個幣別的存款轉帳給其他用戶
# 使用者從交易紀錄得知跟哪些用戶交易過