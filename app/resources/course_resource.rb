class CourseResource < BaseResource
  attributes :name, :num_holes, :state, :city, :basket_type, :tee_type
  has_many :holes
  has_one :course

  filter :id
  filters :state, :num_holes

  filter :name, apply: -> (records, value, _options) {
    records.where('lower(name) LIKE ?', "%#{value[0].downcase}%")
  }

  filter :city, apply: -> (records, value, _options) {
    # return all courses that are within a 45 miles radius of this city
    records.near(value[0],45)
  }

  filter :latlng, apply: -> (records, value, _options) {
    records.near(value, 45)
  }
end
