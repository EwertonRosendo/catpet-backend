# app/lib/json_web_token.rb
class JsonWebToken
  # chave secreta - usar credenciais ou SECRET_KEY_BASE em produção
  HMAC_SECRET = Rails.application.credentials.secret_key_base || ENV['SECRET_KEY_BASE'] || Rails.application.secrets.secret_key_base

  def self.encode(payload, exp = 24.hours.from_now)
    payload = payload.dup
    payload[:exp] = exp.to_i
    JWT.encode(payload, HMAC_SECRET)
  end

  def self.decode(token)
    decoded = JWT.decode(token, HMAC_SECRET)[0]
    HashWithIndifferentAccess.new(decoded)
  rescue JWT::ExpiredSignature
    raise ExceptionHandler::ExpiredSignature, "Token has expired"
  rescue JWT::DecodeError => e
    raise ExceptionHandler::DecodeError, e.message
  end
end
