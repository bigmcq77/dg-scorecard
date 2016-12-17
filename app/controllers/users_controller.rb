class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :authenticate_user, except: :create

  # GET /users
  def index
    @users = User.all
    # allow any auth'd user to see the list of users
    if current_user
      render json: @users
    end
  end

  # GET /users/:id
  def show
    # only allow the current user to view their own page
    if current_user == @user
      render json: current_user
    else
      render json: { error: "Not Authorized" }, status: 401
    end
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PUT/PATCH /users/:id
  def update
    # only allow the current user to edit their own page
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


  # DELETE /users/:id
  def destroy
    # only allow the current user to delete their self
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
