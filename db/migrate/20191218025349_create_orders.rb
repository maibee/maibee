class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :currency, null: false, foreign_key: true
      t.decimal :amount
      t.decimal :price
      t.integer :status

      t.timestamps
    end
  end
end
