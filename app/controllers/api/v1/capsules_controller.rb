class Api::V1::CapsulesController < ApplicationController
  
  def index
    # byebug
    capsules = current_user.capsules
    # byebug
    render json: capsules
  end

  def show
    capsule = Capsule.find(params[:id])
    items = capsule.items
    render json: 
      {
        capsule: capsule,
        items: items
      }
  end

  def create
    # makes the old active capsules inactive (active = false) so that the user can only have one active capsule at a time
    if capsule_params['active'] == true
      old_active = current_user.capsules.where(active: true)
      old_active.update(active: false)
    end

    @capsule = Capsule.new(capsule_params)
    @capsule.user_id = current_user.id

    if @capsule.valid?
      render json:
      {capsule: CapsuleSerializer.new(@capsule)},
      status: :created
    else
      render json:
      {error: 'Capsule not created.'},
      status: :not_acceptable
    end
  end

  def update
    byebug
    @capsule = Capsule.find(params[:capsule_id])
    @item = Item.find(params[:item_id])

    if @capsule.items.include?(@item)
      render json: {error: 'Item already exists in the capsule'}, status: :not_acceptable
    else
      @capsule.items << @item
      @capsule.save
      render json: {message: 'Successfully added item to capsule'}, status: :accepted
    end
  end

  def destroy
    @capsule = Capsule.find(params[:id])
    @user = User.find(@capsule.user_id)
    if !@capsule.delete
      render json: {error: 'Capsule could not be deleted'}
    else
      if @user.capsules.last
        @user.capsules.last.update(active: true)
      end
      render json: {message: 'Successfully deleted capsule'}, status: :accepted
    end
  end

  private

  def capsule_params
    params.require(:capsule).permit(:title, :description, :season, :colors, :active)
  end

end
