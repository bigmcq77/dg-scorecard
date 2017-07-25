class Course < ApplicationRecord
  has_many :holes
  after_create :init_holes

  validates :name, presence: true
  validates :num_holes, numericality: { greater_than: 0 }

  def init_holes
    self.num_holes.times do |i|
      self.holes.create!(number: i+1, par: 3)
    end
  end
end
