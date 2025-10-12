# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :authenticate_request!

  def profile
    render json: { user: { id: current_user.id, name: current_user.name, email: current_user.email } }
  end
end
