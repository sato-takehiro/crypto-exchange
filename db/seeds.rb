# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

cryptocurrency_names = [ 'Bitcoin', 'Ethereum' ]
exchange_names = [ 'Coincheck', 'GMOコイン', 'bitFlyer', 'bitbank', 'BitTrade', 'BITPoint' ]
cryptocurrencies = [
  [ 'Bitcoin', 'BTC', icon: File.open("./public/images/bitcoin.svg") ],
  [ 'Ethereum', 'ETH', icon: File.open("./public/images/eth.svg") ]
]
buying_fees = [ 0, 0, 0.05, 0.05, 0.01, 0.12, 0.12, 0, 0, 0, 0 ]

cryptocurrencies.each do |name, code, icon|
  cryptocurrency = Cryptocurrency.create!({ name: name, code: code, icon: icon })
  puts "\"#{cryptocurrency.name}\" has created!"
end

exchange_names.each do |exchange_name|
  exchange = Exchange.create!(name: exchange_name)
  puts "\"#{exchange.name}\" has created!"
end

cryptocurrency_prices = []
exchange_names.each do |exchange_name|
  exchange = Exchange.find_by(name: exchange_name)
  cryptocurrency_names.each do |cryptocurrency_name|
    cryptocurrency = Cryptocurrency.find_by(name: cryptocurrency_name)
    break if (exchange_name == 'bitFlyer') and (cryptocurrency_name == 'Ethereum')
    cryptocurrency_price = CryptocurrencyPrice.create!(exchange_id: exchange.id, cryptocurrency_id: cryptocurrency.id, asking_price: 0)
    cryptocurrency_prices.push(cryptocurrency_price)
    puts "\"#{cryptocurrency_price.id},#{cryptocurrency_price.exchange_id},#{cryptocurrency_price.cryptocurrency_id}\" has created!"
  end
end

cryptocurrency_prices.each_with_index do |cryptocurrency_price, idx|
  cryptocurrency_price.create_buying_fee!(buying_fee: buying_fees[idx])
  puts "\"#{cryptocurrency_price.buying_fee.buying_fee}\" has created!"
end

network_names = [ 'Bitcoin', 'Ethereum', 'Arbitrum One', 'Optimism' ]
network_names.each do |name|
  network = Network.create!(name: name)
  puts "\"#{network.name}\" has created!"
end

crypto_withdrawal_fees = [
  [ 'Bitcoin', 'Coincheck', 'Bitcoin', 0.0005, 0.00000547 ],
  [ 'Ethereum', 'Coincheck', 'Ethereum', 0.005, 0.000021 ],
  [ 'Bitcoin', 'GMOコイン', 'Bitcoin', 0, 0.00000547 ],
  [ 'Ethereum', 'GMOコイン', 'Ethereum', 0, 0.000021 ],
  [ 'Bitcoin', 'bitFlyer', 'Bitcoin', 0.0004, 0.001 ],
  [ 'Bitcoin', 'bitbank', 'Bitcoin', 0.0006, 0.0001 ],
  [ 'Ethereum', 'bitbank', 'Ethereum', 0.005, 0.001 ],
  [ 'Ethereum', 'bitbank', 'Arbitrum One', 0.00042, 0.001 ],
  [ 'Ethereum', 'bitbank', 'Optimism', 0.00042, 0.001 ],
  [ 'Bitcoin', 'BitTrade', 'Bitcoin', 0.0005, 0.001 ],
  [ 'Ethereum', 'BitTrade', 'Ethereum', 0.005, 0.01 ],
  [ 'Bitcoin', 'BITPoint', 'Bitcoin', 0, 0.00000547 ],
  [ 'Ethereum', 'BITPoint', 'Ethereum', 0, 0.00000001 ]
]
crypto_withdrawal_fees.each do |cryptocurrency_name, exchange_name, network_name, minimum_withdrawal, withdrawal_fee|
  cryptocurrency = Cryptocurrency.find_by(name: cryptocurrency_name)
  exchange = Exchange.find_by(name: exchange_name)
  cryptocurrency_price = CryptocurrencyPrice.find_by(cryptocurrency_id: cryptocurrency.id, exchange_id: exchange.id)
  network = Network.find_by(name: network_name)
  crypto_withdrawal_fee = CryptoWithdrawalFee.create!(
    cryptocurrency_price_id: cryptocurrency_price.id,
    network_id: network.id,
    minimum_withdrawal: minimum_withdrawal,
    withdrawal_fee: withdrawal_fee
  )
  puts "\"#{crypto_withdrawal_fee.id}\" has created!"
end
