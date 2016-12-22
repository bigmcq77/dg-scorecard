class RoundPolicy < ApplicationPolicy
  def index?
    !user.nil?
  end

  def show?
    true
  end

  def create?
    true
  end

  def new?
    create?
  end

  def update?
    user.id == record.user_id
  end

  def destroy?
    user.id == record.user_id
  end

  # class Scope < Scope
  #   def resolve
  #     scope.where(user: @user)
  #   end
  # end
end
