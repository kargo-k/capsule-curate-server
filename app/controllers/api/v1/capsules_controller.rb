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

end
