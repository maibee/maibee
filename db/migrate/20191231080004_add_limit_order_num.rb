class AddLimitOrderNum < ActiveRecord::Migration[6.0]
  def change
    add_column :limit_orders, :num, :string
  end
end
