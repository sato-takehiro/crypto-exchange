class CreateLimitOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :limit_orders do |t|
      t.float :asking_purchase_price, null: false
      t.float :asking_purchase_amount, null: false
      t.integer :purpose, null: false
      t.references :cryptocurrency, null: false, foreign_key: true

      t.timestamps
    end
    add_check_constraint :limit_orders, "asking_purchase_price > 0", name: "asking_purchase_price_check"
    add_check_constraint :limit_orders, "asking_purchase_amount > 0", name: "asking_purchase_amount_check"
  end
end
