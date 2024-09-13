class LimitOrder < ApplicationRecord
  belongs_to :cryptocurrency

  enum purpose: { purchase: 1, purchase_to_wallet: 2 }

  validates :asking_purchase_price, presence: true, numericality: true
  validates :asking_purchase_amount, presence: true, numericality: true
  validates :purpose, presence: true, numericality: { only_integer: true }
  validates :cryptocurrency, presence: true

  # 購入可能量を計算
  # (希望購入金額 / 購入価格) × ( 1 - 購入手数料 ) - 出金手数料 = 購入可能量
  def available_asking_purchase_amounts
    response = []

    cryptocurrency_prices = Cryptocurrency.find_by(id: self.cryptocurrency_id).cryptocurrency_prices
    cryptocurrency_prices.each do |cryptocurrency_price|
      asking_purchase_amount = (self.asking_purchase_price / cryptocurrency_price.asking_price) * (1 - cryptocurrency_price.buying_fee.buying_fee * 0.01)
      exchange = cryptocurrency_price.exchange

      if purchase?
        response.push({ exchange: exchange.name, asking_purchase_amount: asking_purchase_amount })
      else
        cryptocurrency_price.crypto_withdrawal_fees.each do |crypto_withdrawal_fee|
          network = crypto_withdrawal_fee.network.name
          response.push({ exchange: exchange.name, asking_purchase_amount: asking_purchase_amount - crypto_withdrawal_fee.withdrawal_fee, network: network })
        end
      end
    end

    response.sort_by! { |a| a[:asking_purchase_amount] }
  end
end
