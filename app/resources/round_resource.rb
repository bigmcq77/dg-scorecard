class RoundResource < JSONAPI::Resource
  attributes :weather
  has_many :scores
  has_one :user
end
