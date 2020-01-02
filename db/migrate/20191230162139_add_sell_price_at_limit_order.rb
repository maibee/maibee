class AddSellPriceAtLimitOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :limit_orders, :sell_price, :decimal
  end
end
