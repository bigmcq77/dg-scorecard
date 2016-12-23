class UserResource < BaseResource
  attributes :name, :email, :password, :password_confirmation
  has_many :rounds
  has_many :scores, through: :rounds

  def fetchable_fields
    super - [:password, :password_confirmation]
  end
end
