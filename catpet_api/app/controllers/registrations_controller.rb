class RegistrationsController < ApplicationController
  # POST /signup
  def create
    user = User.create!(user_params)
    token = JsonWebToken.encode(user_id: user.id)
    render json: { user: user_response(user), token: token, exp: 24.hours.from_now.iso8601 }, status: :created
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def user_response(user)
    {
      id: user.id,
      name: user.name,
      email: user.email,
      created_at: user.created_at
    }
  end
end
