class CreateCryptoWithdrawalFees < ActiveRecord::Migration[7.2]
  def change
    create_table :crypto_withdrawal_fees do |t|
      t.float :minimum_withdrawal, null: false
      t.float :withdrawal_fee, null: false
      t.references :cryptocurrency_price, null: false, foreign_key: true
      t.references :network, null: false, foreign_key: true

      t.timestamps
    end
  end
end
