class Api::V1::CapsulesController < ApplicationController
  
  def index
    # byebug
    capsules = current_user.capsules
    # byebug
    render json: capsules
  end

  def show
    capsule = Capsule.find(params[:id])
    render json: capsule
  end

  def create
    # makes the old active capsules inactive (active = false) so that the user can only have one active capsule at a time
    if capsule_params['active'] == true
      old_active = current_user.capsules.where(active: true)
      old_active.update(active: false)
    end
    # byebug
    @capsule = Capsule.new(capsule_params)
    @capsule.user_id = current_user.id
    # byebug
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
