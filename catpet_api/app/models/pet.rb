class Pet < ApplicationRecord
  belongs_to :user  
  validates :name, :species, presence: true
end
