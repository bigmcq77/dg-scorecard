class CourseResource < BaseResource
  attributes :name, :num_holes, :state, :city, :basket_type, :tee_type
  has_many :holes
  has_one :course

  filter :id
  filters :state, :city, :num_holes

  filter :name, apply: -> (records, value, _options) {
    records.where('lower(name) LIKE ?', "%#{value[0].downcase}%")
  }

end
