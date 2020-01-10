class AddSlugToCurrencies < ActiveRecord::Migration[6.0]
  def change
    add_column :currencies, :slug, :string
    add_index :currencies, :slug, unique: true
  end
end
