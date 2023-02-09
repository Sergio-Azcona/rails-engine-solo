class Api::V1::ItemMerchantsController < ApplicationController
  def show
    # require 'pry';binding.pry
      # begin
      item = Item.find(params[:item_id])
    # rescue ActiveRecord::RecordNotFound 
    #  render json: ErrorMerchantSerializer.message(ErrorMerchant.new("wrong datatype", "Failed", 111))
    # else
      render json: MerchantSerializer.show_serialize(item.merchant)
    # end                  #                         
  end
end