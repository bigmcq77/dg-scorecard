class RoundsController < ApplicationController
  before_action :load_user, only: :create

  def create
    # only the current user should be able to create their own rounds
    if @user == current_user
      super
    else
      head :unauthorized
    end
  end

  private

    def load_user
      if id_exists?
        user_id = params[:data][:relationships][:user][:data][:id]
        if User.exists?(id: user_id)
          @user = User.find(user_id)
        else
          # bad user id
          head :bad_request
        end
      else
        # user id not passed in
        head :bad_request
      end
    end

    # checks if the user id is passed in
    def id_exists?
      params[:data] && params[:data][:relationships] &&
        params[:data][:relationships][:user] &&
        params[:data][:relationships][:user][:data] &&
        params[:data][:relationships][:user][:data][:id]
    end
end
