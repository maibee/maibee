class RemoveHoneyFromWallets < ActiveRecord::Migration[6.0]
  def change

    remove_column :wallets, :honey, :decimal
  end
end
