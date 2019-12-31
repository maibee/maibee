class RenameRecordToNotification < ActiveRecord::Migration[6.0]
  def change
    rename_table :record, :notification
  end
end
