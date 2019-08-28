class Api::V1::ItemsController < ApplicationController
  
  def index
    items = Item.all
    render json: items
  end

  def show
    item = Item.find(items_params)
    render json: item
  end

  private

  def items_params
    params.require(:id).permit(:category, :color, :brand)
  end

end
