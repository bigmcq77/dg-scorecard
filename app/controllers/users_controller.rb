class UsersController < ApplicationController
  # Only auth'd users can view the list of users and a user page
  # before_action :authenticate_user, only: [:index, :show]
  # # Only the current user can view and edit their self
  # before_action :authenticate, only: [:destroy, :update]

  # private
  #   def authenticate
  #     user = User.find(params[:id])
  #     head :unauthorized unless user == current_user
  #   end
  #
end
