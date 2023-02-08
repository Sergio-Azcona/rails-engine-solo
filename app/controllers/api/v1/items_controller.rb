class Api::V1::itemsController < ApplicationController
  def index
    render json: Item.all
  end

  def show
    render json: Item.find(params[:id]) 
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