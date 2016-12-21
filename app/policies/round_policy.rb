class RoundPolicy < ApplicationPolicy
  def index?
    true
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
    true
  end
end
