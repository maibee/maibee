class AddIsSellToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :is_sell, :boolean, default: false
  end
end
