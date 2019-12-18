class AddCodenameToCurrencies < ActiveRecord::Migration[6.0]
  def change
    add_column :currencies, :codename, :string
  end
end
