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
      if params[:data] && params[:data][:attributes]
        user_id = params[:data][:attributes][:'user-id']
        if User.exists?(id: user_id)
          @user = User.find(user_id)
        else
          # user_id wasn't valid
          head :bad_request
        end
      else
        # user_id wasn't passed in
        head :bad_request
      end
    end
end
