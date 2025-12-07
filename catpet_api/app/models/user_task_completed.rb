class UserTaskCompleted < ApplicationRecord
  belongs_to :user
  belongs_to :quest

  validates :user_id, uniqueness: { scope: :quest_id, message: "já completou esta quest" }
end
