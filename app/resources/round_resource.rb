class RoundResource < BaseResource
  attributes :weather
  has_many :scores
  has_one :user
  has_one :course
 
  paginator :none

  filter :user
end
