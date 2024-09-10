class CreateCryptocurrencyPrices < ActiveRecord::Migration[7.2]
  def change
    create_table :cryptocurrency_prices do |t|
      t.references :cryptocurrency, null: false, foreign_key: true
      t.references :exchange, null: false, foreign_key: true
      t.float :asking_price

      t.timestamps
    end
    add_check_constraint :cryptocurrency_prices, "asking_price >= 0", name: "asking_price_check"
  end
end
