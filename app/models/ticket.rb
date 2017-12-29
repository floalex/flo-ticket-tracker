class Ticket < ApplicationRecord
  STATUSES = %w(new blocked in_progress fixed)
  
  scope :open, -> { where("status != ?", "fixed") }
  
  validates :name, presence: true
  validates :status, inclusion: { in: STATUSES }
  validates :project_id, presence: true
  
  belongs_to :project
  belongs_to :creator, foreign_key: 'user_id', class_name: "User" #creator is the owner of the ticket
  belongs_to :assignee, class_name: "User"
  
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :comments, dependent: :destroy
  
  def self.search_by_name_or_description(search_term)
    # use of %: WHERE LIKE '%or%':	Finds any values that have "or" in any position
    where("LOWER(tickets.name) LIKE ? or LOWER(tickets.body) LIKE ?", "%#{search_term.downcase}%", "%#{search_term.downcase}%")
  end
end