class AddAmountToWallets < ActiveRecord::Migration[6.0]
  def change
    add_column :wallets, :amount, :decimal
  end
end
