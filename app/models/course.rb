class Course < ApplicationRecord
  has_many :holes

  validates :name, presence: true
  validates :num_holes, numericality: { greater_than: 0 }

  geocoded_by :address
  after_validation :geocode

  def address
    return "#{city}, #{state}"
  end
end
