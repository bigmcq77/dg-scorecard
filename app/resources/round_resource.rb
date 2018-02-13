class RoundResource < BaseResource
  attributes :weather, :updated_at
  has_many :scores
  has_one :user
  has_one :course
 
  paginator :none

  filter :user
end
