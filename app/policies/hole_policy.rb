class HolePolicy < ApplicationPolicy
  def index?
    !user.nil?
  end

  def show?
    true
  end

  def create?
    !user.nil?
  end

  def new?
    create?
  end

  def update?
    !user.nil?
  end

  def destroy?
    !user.nil?
  end
end
