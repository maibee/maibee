class CreateCurrencies < ActiveRecord::Migration[6.0]
  def change
    create_table :currencies do |t|
      t.string :name
      t.decimal :last_rate
      t.datetime :update_time

      t.timestamps
    end
  end
end
