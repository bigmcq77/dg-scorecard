class User < ApplicationRecord
  has_secure_password

  has_many :rounds

  validates_presence_of :name, :email
end
