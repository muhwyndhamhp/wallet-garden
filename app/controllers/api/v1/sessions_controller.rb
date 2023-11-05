class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: session_params[:email])

    if user&.authenticate(session_params[:password])
      user.regenerate_auth_token
      render json: { auth_token: user.auth_token }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def destroy
    @current_user.invalidate_auth_token
    head :no_content
  end

  def session_params
    params.permit(:email, :password, :auth_token)
  end
end
