class UserPolicy < ApplicationPolicy
  def index?
    !user.nil?
  end

  def show?
    !user.nil?
  end

  # anybody can create a user
  def create?
    true
  end

  def new?
    create?
  end

  def update?
    record == @user
  end

  def destroy?
    record == @user
  end
end
