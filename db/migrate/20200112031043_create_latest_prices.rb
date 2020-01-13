class CreateLatestPrices < ActiveRecord::Migration[6.0]
  def change
    create_table :latest_prices do |t|
      t.references :currency, null: false, foreign_key: true
      t.decimal :price
      t.decimal :volume_24h
      t.decimal :percent_change_1h
      t.decimal :percent_change_24h
      t.decimal :percent_change_7d

      t.timestamps
    end
  end
end
