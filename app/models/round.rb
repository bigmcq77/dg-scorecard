class Round < ApplicationRecord
  belongs_to :user
  belongs_to :course

  has_many :scores

  def score
    score = 0
    scores = self.scores.includes(:hole)
    scores.each do |s|
      score += s.strokes - s.hole.par
    end
    score
  end
end
