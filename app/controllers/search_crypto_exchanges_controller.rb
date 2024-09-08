class SearchCryptoExchangesController < ApplicationController
  def select_purpose; end

  def select_coin
    @select_coin = SelectCoinForm.new
  end

  def result; end
end
