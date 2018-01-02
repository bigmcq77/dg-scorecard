class Course < ApplicationRecord
  has_many :holes

  validates :name, presence: true
  validates :num_holes, numericality: { greater_than: 0 }
end
