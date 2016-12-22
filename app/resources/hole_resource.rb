class HoleResource < BaseResource
  attributes :number, :par
  has_one :course
end
