class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true
  validates :username, uniqueness: { case_sensitive: false }
  has_many :goals
end
