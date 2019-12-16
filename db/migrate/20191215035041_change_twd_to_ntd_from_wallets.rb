class ChangeTwdToNtdFromWallets < ActiveRecord::Migration[6.0]
  def change
    rename_column :wallets, :twd, :ntd
  end
end
