class CryptocurrencyPrice < ApplicationRecord
  belongs_to :cryptocurrency
  belongs_to :exchange

  has_one :buying_fee, dependent: :destroy
  has_many :crypto_withdrawal_fees, dependent: :destroy

  validates :asking_price, numericality: { greater_than_or_equal_to: 0 }
end
