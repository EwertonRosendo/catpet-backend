class SessionsController < ApplicationController
  # POST /login
  def create
    user = User.find_by(email: params[:email].to_s.downcase.strip)
    if user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: user.id)
      render json: { user: user_response(user), token: token, exp: 24.hours.from_now.iso8601 }, status: :ok
    else
      render json: { errors: ['Invalid email or password'] }, status: :unauthorized
    end
  end

  private

  def user_response(user)
    {
      id: user.id,
      name: user.name,
      email: user.email,
      xp: user.xp
    }
  end
end
