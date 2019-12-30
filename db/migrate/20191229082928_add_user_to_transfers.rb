class AddUserToTransfers < ActiveRecord::Migration[6.0]
  def change
    add_reference :transfers, :user, null: false, foreign_key: true
  end
end
