class CourseResource < BaseResource
  attributes :name, :num_holes
  has_many :holes
  has_one :course
end
