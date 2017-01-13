class RoundResource < BaseResource
  attributes :weather, :score
  has_many :scores
  has_one :user
  has_one :course
end
