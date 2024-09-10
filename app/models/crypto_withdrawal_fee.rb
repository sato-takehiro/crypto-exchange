class CryptoWithdrawalFee < ApplicationRecord
  belongs_to :cryptocurrency_price
  belongs_to :network

  validates :minimum_withdrawal, presence: true, numericality: true
  validates :withdrawal_fee, presence: true, numericality: true
end
