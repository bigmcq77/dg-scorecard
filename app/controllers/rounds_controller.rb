class RoundsController < ApplicationController
  before_action :authenticate_user, only: [:index, :show]
  # only the current user can edit and update their own rounds
  before_action :authenticate, only: [:update, :delete]
  before_action :load_user, only: [:create]

  def create
    if @user == current_user
      super
    else
      head :unauthorized
    end
  end

  private
  def authenticate
    round = Round.find(params[:id])
    user = User.find(round.user_id)
    head :unauthorized unless user == current_user
  end

  def load_user
    if params[:data] && params[:data][:attributes]
      user_id = params[:data][:attributes][:'user-id']
      @user = User.find(user_id)
    else
      head :unauthorized
    end
  end
end
