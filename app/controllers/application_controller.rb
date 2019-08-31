class ApplicationController < ActionController::API
  before_action :authorized

  def encode_token(payload)
    # byebug
    JWT.encode(payload, ENV['JWT_SECRET'])
  end

  def auth_header
    # byebug
    request.headers['Authorization']
  end

  def decoded_token(token)
    # byebug
    if auth_header
      token = auth_header.split(" ")[1]
      begin 
        JWT.decode(token, ENV['JWT_SECRET'], true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def current_user
    # byebug
    token = decoded_token(@token)
    if token
      user_id = token[0]['user_id']
      @user = User.find(user_id)
    end
  end

  def logged_in?
    # byebug
    !!current_user
  end

  def authorized
    # byebug
    render json: {message: 'Please log in'}, status: :unauthorized unless logged_in?
  end

end
