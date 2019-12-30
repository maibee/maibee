class CreateTransfers < ActiveRecord::Migration[6.0]
  def change
    create_table :transfers do |t|
      t.references :currency, null: false, foreign_key: true
      t.decimal :amount
      t.string :target
      t.string :num

      t.timestamps
    end
  end
end
