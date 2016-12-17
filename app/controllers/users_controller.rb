class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :authenticate_user, except: :create

  def index
    @users = User.all
    if current_user
      render json: @users
    end
  end

  def show
    if current_user == @user
      render json: current_user
    else
      render json: { error: "Not Authorized" }, status: 401
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if current_user == @user
      if @user.update(user_params)
        render json: @user, status: 200
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    else
      render json: { error: "Not Authorized" }, status: 401
    end
  end


  def destroy
    if current_user == @user
      @user.destroy
      head 204
    else
      render json: { error: "Not Authorized" }, status: 401
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      ActiveModelSerializers::Deserialization.jsonapi_parse(params)
    end
end
