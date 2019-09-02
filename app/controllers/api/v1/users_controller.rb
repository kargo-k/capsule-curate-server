class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create
    @user = User.new(user_params)
    @user.save!

    if @user.valid?
      @token = encode_token(user_id: @user.id)
      render json: 
      { 
        user: UserSerializer.new(@user),
        jwt: @token 
      },
      status: :created
    else
      render json:
        {error: 'User not created.'},
        status: :not_acceptable
    end
  end

  def profile
    render json: {
      user: UserSerializer.new(current_user)
    }, 
    status: :accepted
  end

  def destroy
    if @user = current_user.delete
      render json: {user: UserSerializer.new(@user)},
      status: :deleted
    else
      render json: {error: 'User cannot be deleted.'}
    end
  end

  private

    def user_params
      params.require(:user).permit(:username, :password, :location)
    end

end
