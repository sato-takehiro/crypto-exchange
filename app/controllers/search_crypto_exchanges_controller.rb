class SearchCryptoExchangesController < ApplicationController
  def select_purpose; end

  def select_coin
    @select_coin = SelectCoinForm.new
  end

  def select_coin_to_wallet
    @select_coin_to_wallet = SelectCoinForm.new
  end

  def result; end

  def result_to_wallet; end
end
