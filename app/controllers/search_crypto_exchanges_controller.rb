class SearchCryptoExchangesController < ApplicationController
  def select_purpose; end

  def select_coin
    @select_coin_form = SelectCoinForm.new
  end

  def select_coin_to_wallet
    @select_coin_form = SelectCoinForm.new
  end

  def result
    @select_coin_form = SelectCoinForm.new(search_crypto_exchange_params)
    if @select_coin_form.valid?
      limit_order = LimitOrder.new(cryptocurrency_id: search_crypto_exchange_params[:cryptocurrency_id], asking_purchase_price: search_crypto_exchange_params[:asking_purchase_price], purpose: 1)
      @asking_purchase_amounts = limit_order.available_asking_purchase_amounts
      render :result, asking_purchase_amounts: @asking_purchase_amounts
    else
      render :select_coin, status: :unprocessable_entity
    end
  end

  def result_to_wallet
    @select_coin_form = SelectCoinForm.new(search_crypto_exchange_params)
    if @select_coin_form.valid?
      limit_order = LimitOrder.new(cryptocurrency_id: search_crypto_exchange_params[:cryptocurrency_id], asking_purchase_price: search_crypto_exchange_params[:asking_purchase_price], purpose: 2)
      @asking_purchase_amounts = limit_order.available_asking_purchase_amounts
      render :result_to_wallet, asking_purchase_amounts: @asking_purchase_amounts
    else
      render :select_coin, status: :unprocessable_entity
    end
  end

  private

  def search_crypto_exchange_params
    params.require(:select_coin_form).permit(:cryptocurrency_id, :asking_purchase_price)
  end
end
