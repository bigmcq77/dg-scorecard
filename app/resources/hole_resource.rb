class HoleResource < BaseResource
  attributes :number, :par, :distance
  has_one :course

  def self.sortable_fields(context)
    super + [:"number"]
  end
end
