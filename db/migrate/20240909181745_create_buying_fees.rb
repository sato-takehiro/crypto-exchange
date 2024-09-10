class CreateBuyingFees < ActiveRecord::Migration[7.2]
  def change
    create_table :buying_fees do |t|
      t.float :buying_fee
      t.belongs_to :cryptocurrency_price, null: false, foreign_key: true

      t.timestamps
    end
  end
end
