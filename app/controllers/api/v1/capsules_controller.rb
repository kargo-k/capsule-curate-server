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
    # TODO: if active, make old capsule active to false
    @capsule = Capsule.new(capsule_params)
    @capsule.update(user_id: current_user.id)
    @capsule.save!

    if @capsule.valid?
      byebug
      render json:
      {capsule: CapsuleSerializer.new(@capsule)},
      status: :created
    else
      render json:
      {error: 'Capsule not created.'},
      status: :not_acceptable
    end
  end

  private

  def capsule_params
    params.require(:capsule).permit(:title, :description, :season, :colors, :active)
  end
end
