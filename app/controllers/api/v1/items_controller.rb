class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.index_serialize(Item.all)
  end

  def show
    render json: ItemSerializer.show_serialize(Item.find(params[:id])) 
  end

  def create 
    Item.find(params[:id]) 
  end

  def update
    Item.find(params[:id]) 
  end

  def destroy
    item = Item.find(params[:id]) 
  end


end