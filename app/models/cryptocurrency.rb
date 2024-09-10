class Cryptocurrency < ApplicationRecord
  mount_uploader :icon, CryptocurrencyUploader

  has_many :cryptocurrency_prices, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :code, presence: true
end
