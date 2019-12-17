class AddDetailsToWallets < ActiveRecord::Migration[6.0]
  def change
    add_column :wallets, :currency, :string
    add_column :wallets, :recognition, :string
  end
end
