class Api::V1::CapsulesController < ApplicationController
  
  def index
    capsules = Capsule.all
    render json: capsules
  end

  def show
    capsule = Capsule.find(params[:id])
    render json: capsule
  end

end
