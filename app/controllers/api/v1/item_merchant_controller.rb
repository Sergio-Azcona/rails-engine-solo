class Api::V1::ItemMerchantController < ApplicationController
  def index
    item = Item.find(params[:item_id])
    render json: MerchantSerializer.show_serialize(item.merchant)
  end
end