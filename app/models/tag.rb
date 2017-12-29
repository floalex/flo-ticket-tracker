class Tag < ApplicationRecord
  scope :alphabetical, -> { order("tags.name ASC") }
  
  scope :with_counts, -> {
    joins("LEFT JOIN taggings ON taggings.tag_id = tags.id").select("tags.*, COUNT(taggings.id)").
      group("tags.id")
  }
  
  validates :name, presence: true
  
  has_many :taggings, dependent: :destroy
  has_many :tickets, through: :taggings
end