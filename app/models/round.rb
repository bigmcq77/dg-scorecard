class Round < ApplicationRecord
  belongs_to :user
  belongs_to :course

  has_many :scores, :dependent => :destroy

  after_create :init_scores

  def init_scores
    self.course.holes.each do |hole|
      self.scores.create!(hole: hole, round: self, strokes: hole.par)
    end
  end
end
