class User < ApplicationRecord
  has_secure_password

  before_save :downcase_email

  VALID_EMAIL_REGEX = /\A[^@\s]+@[^@\s]+\z/

  validates :name, presence: true, length: { maximum: 100 }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

  
  has_many :pets, dependent: :destroy
  

  private

  def downcase_email
    self.email = email.downcase.strip
  end
end
