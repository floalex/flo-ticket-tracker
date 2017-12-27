class Ticket < ApplicationRecord
  STATUSES = %w(new blocked in_progress fixed)
  
  validates :name, presence: true
  validates :status, inclusion: { in: STATUSES }
  validates :open, inclusion: { in: [true, false] }
  validates :project_id, presence: true
  
  belongs_to :project
  belongs_to :creator, class_name: "User"
  belongs_to :assignee, class_name: "User"
  
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :comments
end