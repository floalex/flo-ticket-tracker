class Ticket < ApplicationRecord
  STATUSES = %w(new blocked in_progress fixed)
  
  validates :name, presence: true
  validates :status, inclusion: { in: STATUSES }
  validates :open, inclusion: { in: [true, false] }
  validates :project_id, presence: true
  
  belongs_to :project
  
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
end