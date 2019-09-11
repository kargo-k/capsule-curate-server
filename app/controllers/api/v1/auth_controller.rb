class Api::V1::AuthController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create
    @user = User.find_by(username: user_login_params[:username])
    if @user && @user.authenticate(user_login_params[:password])
      token = encode_token({user_id: @user.id})
      active_capsule = @user.capsules.where(active: true)
      if !active_capsule
        active_capsule = @user.capsules.last
      end
      render json: { 
        user: UserSerializer.new(@user), 
        capsule: active_capsule[0],
        jwt: token,
        status: 200
      }, 
        status: :accepted
    else
      render json: {error: 'Invalid username or password'},
      status: :unauthorized
    end
  end

  private

  def user_login_params
    params.require(:user).permit(:username, :password)
  end

end
