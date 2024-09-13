require "json"

class Tasks::AskingPurchasePrice < ApplicationRecord
  INTERVAL = 1

  def self.get
    loop do
      sleep(INTERVAL)
      from_coincheck
      from_gmo_coin
      from_bitflyer
      from_bitbank
      from_bittrade
    end
  end

  def self.from_coincheck
    pairs = { Bitcoin: "btc_jpy", Ethereum: "eth_jpy" }
    exchange = Exchange.find_by(name: "Coincheck")

    pairs.each do |cryptocurrency_name, pair|
      json = HTTP.get("https://coincheck.com/api/ticker?pair=#{pair}")
      response = JSON.parse(json)

      cryptocurrency = Cryptocurrency.find_by(name: cryptocurrency_name)
      cryptocurrency_price = CryptocurrencyPrice.find_by(exchange_id: exchange.id, cryptocurrency_id: cryptocurrency.id)

      asking_price = response["ask"]
      if cryptocurrency_price.update(asking_price: asking_price)
        puts cryptocurrency_price.asking_price
      else
        puts "failed to save from coincheck"
      end
    end
  end

  def self.from_gmo_coin
    pairs = { Bitcoin: "BTC_JPY", Ethereum: "ETH_JPY" }
    exchange = Exchange.find_by(name: "GMOコイン")

    json = HTTP.get("https://api.coin.z.com/public/v1/ticker")
    response = JSON.parse(json)

    pairs.each do |cryptocurrency_name, pair|
      cryptocurrency = Cryptocurrency.find_by(name: cryptocurrency_name)
      cryptocurrency_price = CryptocurrencyPrice.find_by(exchange_id: exchange.id, cryptocurrency_id: cryptocurrency.id)

      asking_price = response["data"].find { |item| item["symbol"] == pair }["ask"]
      if cryptocurrency_price.update(asking_price: asking_price)
        puts cryptocurrency_price.asking_price
      else
        puts "failed to save from gmo coin"
      end
    end
  end

  def self.from_bitflyer
    pairs = { Bitcoin: "BTC_JPY" }
    exchange = Exchange.find_by(name: "bitFlyer")

    json = HTTP.get("https://bitflyer.com/api/echo/price")
    response = JSON.parse(json)

    pairs.each do |cryptocurrency_name, pair|
      cryptocurrency = Cryptocurrency.find_by(name: cryptocurrency_name)
      cryptocurrency_price = CryptocurrencyPrice.find_by(exchange_id: exchange.id, cryptocurrency_id: cryptocurrency.id)

      asking_price = response["ask"]
      if cryptocurrency_price.update(asking_price: asking_price)
        puts cryptocurrency_price.asking_price
      else
        puts "failed to save from bitflyer"
      end
    end
  end

  def self.from_bitbank
    pairs = { Bitcoin: "btc_jpy", Ethereum: "eth_jpy" }
    exchange = Exchange.find_by(name: "bitbank")

    json = HTTP.get("https://public.bitbank.cc/tickers")
    response = JSON.parse(json)

    pairs.each do |cryptocurrency_name, pair|
      cryptocurrency = Cryptocurrency.find_by(name: cryptocurrency_name)
      cryptocurrency_price = CryptocurrencyPrice.find_by(exchange_id: exchange.id, cryptocurrency_id: cryptocurrency.id)

      asking_price = response["data"].find { |item| item["pair"] == pair }["sell"]
      if cryptocurrency_price.update(asking_price: asking_price)
        puts cryptocurrency_price.asking_price
      else
        puts "failed to save from bitbank"
      end
    end
  end

  def self.from_bittrade
    pairs = { Bitcoin: "btcjpy", Ethereum: "ethjpy" }
    exchange = Exchange.find_by(name: "BitTrade")

    pairs.each do |cryptocurrency_name, pair|
      json = HTTP.get("https://api-cloud.bittrade.co.jp/market/detail/merged?symbol=#{pair}")
      response = JSON.parse(json)

      cryptocurrency = Cryptocurrency.find_by(name: cryptocurrency_name)
      cryptocurrency_price = CryptocurrencyPrice.find_by(exchange_id: exchange.id, cryptocurrency_id: cryptocurrency.id)

      asking_price = response["tick"]["ask"][0]
      if cryptocurrency_price.update(asking_price: asking_price)
        puts cryptocurrency_price.asking_price
      else
        puts "failed to save from BitTrade"
      end
    end
  end
end
