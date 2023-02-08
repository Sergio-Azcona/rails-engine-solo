class Api::V1::ItemMerchantsController < ApplicationController
  def show
    # require 'pry';binding.pry
    item = Item.find(params[:item_id])
    render json: item.merchant
  end
end