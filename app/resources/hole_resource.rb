class HoleResource < JSONAPI::Resource
  attributes :number, :par, :course_id
  has_one :course

  def fetchable_fields
    super - [:course_id]
  end
end
