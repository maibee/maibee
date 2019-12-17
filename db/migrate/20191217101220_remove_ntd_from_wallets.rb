class RemoveNtdFromWallets < ActiveRecord::Migration[6.0]
  def change

    remove_column :wallets, :ntd, :decimal
  end
end
