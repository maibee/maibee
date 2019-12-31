class AddTxidToTransfers < ActiveRecord::Migration[6.0]
  def change
    add_column :transfers, :txid, :string
  end
end
