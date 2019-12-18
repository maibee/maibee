class AddCurrencyToWallets < ActiveRecord::Migration[6.0]
  def change
    add_reference :wallets, :currency, null: false, foreign_key: true
  end
end
