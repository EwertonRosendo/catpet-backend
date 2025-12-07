class Quest < ApplicationRecord
  #belongs_to :user

  validates :name, presence: true
  validates :times, numericality: { greater_than: 0 }
  validates :xp, numericality: { greater_than_or_equal_to: 0 }
end
