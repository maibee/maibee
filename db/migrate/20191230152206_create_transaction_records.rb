class CreateTransactionRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :transaction_records do |t|
      t.belongs_to :limit_order, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
