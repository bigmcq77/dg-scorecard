class UserPolicy < ApplicationPolicy
  def index?
    !user.nil?
  end

  def show?
    record == @user
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
