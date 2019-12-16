class AddWalletToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :wallet, null: false, foreign_key: true
  end
end
