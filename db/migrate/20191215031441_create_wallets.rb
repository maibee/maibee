class CreateWallets < ActiveRecord::Migration[6.0]
  def change
    create_table :wallets do |t|
      t.decimal :twd
      t.decimal :xpr
      t.decimal :honey

      t.timestamps
    end
  end
end
