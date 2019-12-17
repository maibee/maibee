class RemoveXprFromWallets < ActiveRecord::Migration[6.0]
  def change

    remove_column :wallets, :xpr, :decimal
  end
end
