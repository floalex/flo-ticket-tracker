class Tag < ApplicationRecord
  scope :alphabetical, -> { order("tags.name ASC") }
  
  validates :name, presence: true
  
  has_many :taggings, dependent: :destroy
  has_many :tickets, through: :taggings
end