class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.index_serialize(Merchant.all)
  end

  def show
    begin
      merchant = Merchant.find(params[:id])
    # if Merchant.exists?(params[:id])
    # rescue ActiveRecord::RecordNotFound 
    #   render json: ErrorMerchantSerializer.message(ErrorMerchant.new("wrong datatype", "Failed", 111))
    # else
      render json: MerchantSerializer.show_serialize(merchant)
    # end                  #                         ("wrong datatype", "Failed", 111)

  end
end