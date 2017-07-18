class User < ApplicationRecord
  has_secure_password

  has_many :rounds
  has_many :scores, through: :rounds

  validates_presence_of :name, :email
  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
end
