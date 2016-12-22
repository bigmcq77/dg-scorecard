class ScorePolicy < ApplicationPolicy
  def index?
    !user.nil?
  end

  def show?
    !user.nil?
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
end
