class HoleResource < JSONAPI::Resource
  attributes :number, :par
  has_one :course
end
