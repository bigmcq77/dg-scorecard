class HoleSerializer < ActiveModel::Serializer
  attributes :id, :number, :par
  has_one :course
end
