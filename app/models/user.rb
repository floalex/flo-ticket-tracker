class User < ActiveRecord::Base

  has_secure_password validations: false
  
  validates :name, presence: true, uniqueness: true
  validates :password, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i # avoid invalid: foo@bar..com
  validates :email, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  
  has_many :tickets, dependent: :destroy 
  has_many :comments, dependent: :destroy 
end