class CourseResource < JSONAPI::Resource
  attributes :name, :num_holes
  has_many :holes
  has_one :course
end
