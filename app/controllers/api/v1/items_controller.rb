class Api::V1::ItemsController < ApplicationController

  
  def index
    render json: ItemSerializer.index_serialize(Item.all)
  end

  def show
    item = Item.find(params[:id])
    render json: ItemSerializer.show_serialize(item) 
  end

  def create 
    # new_item = Item.new(item_params)
    # if new_item.save
    #   render json: ItemSerializer.show_serialize(new_item), status: 201 
    # else
    # # render json: ErrorSerializer.serialized_response(new_item.errors.full_messages.first, 422), status: 422
    #   render json: new_item.errors.full_messages, status: 422
    # # require 'pry';binding.pry
    # end
    begin
      new_item = Item.create!(item_params)
      # new_item.create
      render json: ItemSerializer.show_serialize(new_item), status: 201 
    rescue => error
    render json: ErrorSerializer.serialized_response(error, 422), status: 422
      # render json: new_item.errors.full_messages, status: 422
    # require 'pry';binding.pry
    end
  end

  def update
    updating_item =  Item.find(params[:id]) 
    if updating_item.update(item_params)
      render json: ItemSerializer.show_serialize(updating_item), status: 201 
    else
      render json: updating_item.errors.full_messages, status: 404
    end
  end

  def destroy
    item = Item.find(params[:id]) 
    item.destroy    
  end

  private 
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end