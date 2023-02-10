class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.index_serialize(Merchant.all)
  end

  def show
      merchant = Merchant.find(params[:id])
      render json: MerchantSerializer.show_serialize(merchant)
  end
end