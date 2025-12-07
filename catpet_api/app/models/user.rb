class User < ApplicationRecord
  has_secure_password
  has_many :quests
  before_save :downcase_email

  has_many :user_task_completeds
  has_many :completed_quests, through: :user_task_completeds, source: :quest
  VALID_EMAIL_REGEX = /\A[^@\s]+@[^@\s]+\z/

  validates :name, presence: true, length: { maximum: 100 }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

  
  has_many :pets, dependent: :destroy

  def complete_quest!(quest)
    return false if quest.times <= 0

    transaction do
      update!(xp: xp + quest.xp)
      quest.update!(times: quest.times - 1)
    end

    true
  end
  

  private

  def downcase_email
    self.email = email.downcase.strip
  end
end
