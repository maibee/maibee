class AddOrderTransferLimitorder < ActiveRecord::Migration[6.0]
  def change
    add_column :records, :type, :string
  end
end
