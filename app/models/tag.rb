class Tag < ApplicationRecord
  validates :name, presence: true
  
  has_many :taggings, dependent: :destroy
  has_many :tickets, through: :taggings
end