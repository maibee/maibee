class CreateLimitOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :limit_orders do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :currency, null: false, foreign_key: true
      t.decimal :amount
      t.string :status

      t.timestamps
    end
  end
end
