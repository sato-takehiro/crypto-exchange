class Exchange < ApplicationRecord
  has_many :cryptocurrency_prices, dependent: :destroy

  validates :name, presence: true
end
