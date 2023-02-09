class Api::V1::MerchantsItemsController < ApplicationController
  def index
    begin 
      merchant = Merchant.find(params[:merchant_id])
    rescue ActiveRecord::RecordNotFound
      render json: ErrorIDSerializer.new(ErrorNotFound.new(params[:merchant_id],"NOT FOUND")), status: 404
    else
      render json: ItemSerializer.index_serialize(merchant.items)
    end
  end
end