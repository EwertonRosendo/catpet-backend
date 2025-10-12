class ApplicationController < ActionController::API
  include ExceptionHandler

  private

  # verifica header Authorization: "Bearer <token>"
  def authenticate_request!
    header = request.headers['Authorization']
    header = header.split(' ').last if header.present?
    raise ExceptionHandler::MissingToken, 'Missing token' unless header

    decoded = JsonWebToken.decode(header)
    @current_user = User.find_by(id: decoded[:user_id])
    raise ExceptionHandler::AuthenticationError, 'Invalid token or user not found' unless @current_user
  end

  # helper
  def current_user
    @current_user
  end
end
