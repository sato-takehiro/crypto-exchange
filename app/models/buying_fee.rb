class BuyingFee < ApplicationRecord
  belongs_to :cryptocurrency_price

  validates :buying_fee, presence: true, numericality: true
end
