class Api::V1::ItemsController < ApplicationController
  skip_before_action :authorized
  
  def index
    items = Item.all
    render json: items
  end

  def show
    item = Item.find(params[:id])
    render json: item
  end

  def create
    @item = Item.new(name: item_params[:name].titleize)
    @item.brand = item_params[:brand].titleize
    @item.description = item_params[:description].capitalize
    @item.category = item_params[:category]
    @item.category2 = item_params[:category2]
    @item.image = item_params[:image]
    @item.personal = true

    if @item.valid?
      @item.save
      @capsule = Capsule.find(item_params[:capsule_id])
      @capsule.items << @item
      @capsule.save

      render json: {item: ItemSerializer.new(@item), capsule: CapsuleSerializer.new(@capsule), message: 'Successfully added item to capsule'}, status: :accepted
    else

      render json: {error: 'Item not created.'}, status: :not_acceptable
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :brand, :description, :category, :category2, :image, :capsule_id)
  end

end
