class ChangeRecordColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :records, :type, :order_type 
  end
end
