class CourseResource < BaseResource
  attributes :name, :num_holes, :state, :city, :basket_type, :tee_type
  has_many :holes
  has_one :course

  filter :id
  filters :state, :city, :num_holes
end
