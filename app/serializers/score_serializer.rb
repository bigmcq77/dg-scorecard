class ScoreSerializer < ActiveModel::Serializer
  attributes :id, :strokes
  has_one :round
  has_one :hole
  has_one :user
end
