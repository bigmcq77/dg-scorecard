class Hole < ApplicationRecord
  belongs_to :course

  validates :number, numericality: { greater_than: 0 }
  validates_uniqueness_of :number, scope: :course_id
  validates :par, numericality: { greater_than: 1 }
end
