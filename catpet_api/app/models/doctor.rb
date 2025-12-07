class Doctor < ApplicationRecord
  validates :name, presence: true
  validates :specialty, presence: true
  validates :rating, numericality: { in: 1..5 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_nil: true
end
