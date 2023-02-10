class Api::V1::MerchantsItemsController < ApplicationController
  def index
    # begin 
      merchant = Merchant.find(params[:merchant_id])
      render json: ItemSerializer.index_serialize(merchant.items)
    # rescue => error 
    #   render json: ErrorSerializer.serialized_response(error, 404), status: 404
    # end
  end
end