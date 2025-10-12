# app/controllers/concerns/exception_handler.rb
module ExceptionHandler
  extend ActiveSupport::Concern

  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class DecodeError < StandardError; end
  class ExpiredSignature < StandardError; end

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::MissingToken, with: :missing_token
    rescue_from ExceptionHandler::DecodeError, with: :invalid_token
    rescue_from ExceptionHandler::ExpiredSignature, with: :expired_token
  end

  private

  def render_unprocessable_entity(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end

  def unauthorized_request(exception)
    render json: { errors: [exception.message || "Not Authorized"] }, status: :unauthorized
  end

  def missing_token(exception)
    render json: { errors: [exception.message || "Missing token"] }, status: :unauthorized
  end

  def invalid_token(exception)
    render json: { errors: [exception.message || "Invalid token"] }, status: :unauthorized
  end

  def expired_token(exception)
    render json: { errors: [exception.message || "Expired token"] }, status: :unauthorized
  end
end
