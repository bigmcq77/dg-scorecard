class UserPolicy < ApplicationPolicy
  def index?
    true
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

  # class Scope < Scope
  #   def resolve
  #     scope
  #   end
  # end
end
