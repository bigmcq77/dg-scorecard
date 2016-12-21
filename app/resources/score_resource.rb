class ScoreResource < BaseResource
  attributes :strokes
  has_one :hole
  has_one :user
  has_one :round
end
