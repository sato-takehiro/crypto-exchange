class Network < ApplicationRecord
  has_many :crypto_withdrawal_fees

  validates :name, presence: true
end
