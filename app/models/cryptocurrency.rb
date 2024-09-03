class Cryptocurrency < ApplicationRecord
  mount_uploader :icon, CryptocurrencyUploader

  validates :name, presence: true, uniqueness: true
  validates :code, presence: true
end
