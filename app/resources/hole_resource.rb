class HoleResource < BaseResource
  attributes :number, :par
  has_one :course

  def self.sortable_fields(context)
    super + [:"number"]
  end
end
