FactoryBot.define do
  factory :crypto_withdrawal_fee do
    minimum_withdrawal { 1.5 }
    withdrawal_fee { 1.5 }
    cryptocurrency_price { nil }
  end
end
