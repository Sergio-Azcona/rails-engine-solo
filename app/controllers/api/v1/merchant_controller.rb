class Api::V1::MerchantController < ApplicationController
  def index
    render json: MerchantSerializer.index_serialize(Merchant.all)
  end

  def show
    render json: MerchantSerializer.show_serialize(Merchant.find(params[:id])) 
  end
end