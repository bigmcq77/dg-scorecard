class Round < ApplicationRecord
  belongs_to :user
  belongs_to :course

  has_many :scores, :dependent => :destroy
  after_create :init_scores

  def score
    score = 0
    scores = self.scores.includes(:hole)
    scores.each do |s|
      score += s.strokes - s.hole.par
    end
    score
  end

  def init_scores
    self.course.holes.count.times do |i|
      hole = self.course.holes[i]
      self.scores.create!(strokes: hole.par, hole: hole) 
    end
  end
end
