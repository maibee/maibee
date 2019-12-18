class RemoveCurrencyFromWallets < ActiveRecord::Migration[6.0]
  def change

    remove_column :wallets, :currency, :string
  end
end
