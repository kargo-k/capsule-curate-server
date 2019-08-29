class Api::V1::UsersController < ApplicationController

  def create

    @user = User.new(user_params)
    @user.save!

    if @user.valid?
      render json: 
        { user: UserSerializer.new(@user) },
        status: :created
    else
      render json:
        {error: 'Username already exists - Please choose a new username.'},
        status: :not_acceptable
    end
  end

  private

    def user_params
      params.require(:user).permit(:username, :password, :location)
    end

end
