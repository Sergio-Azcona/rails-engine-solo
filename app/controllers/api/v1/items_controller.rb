class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.index_serialize(Item.all)
  end

  def show
    render json: ItemSerializer.show_serialize(Item.find(params[:id])) 
  end

  def create 
    new_item = Item.new(item_params)
    # require 'pry';binding.pry
    if new_item.save
      render json: ItemSerializer.show_serialize(new_item), status: 201
      # render BookSerializer.one_book(new_item)
    else
      render json: new_item.errors.full_messages, status: 422
    end
  end

  def update
    Item.find(params[:id]) 
  end

  def destroy
    item = Item.find(params[:id]) 
  end

  private 
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end