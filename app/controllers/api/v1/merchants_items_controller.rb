class Api::V1::MerchantsItemsController < ApplicationController
  def index
      merchant = Merchant.find(params[:merchant_id])
      render json: ItemSerializer.index_serialize(merchant.items)
  end
end