class CreateCryptocurrencies < ActiveRecord::Migration[7.2]
  def change
    create_table :cryptocurrencies do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.string :icon

      t.timestamps
    end
    add_index :cryptocurrencies, :name, unique: true
  end
end
