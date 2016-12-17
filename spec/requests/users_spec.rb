require 'rails_helper'

RSpec.describe "Users", :type => :request do

  before(:each) do
    @user1 = FactoryGirl.create :user, name: 'Nate Sexton'
    @user2 = FactoryGirl.create :user, name: 'Paul McBeth'
  end

  def authenticated_header(user)
    token = Knock::AuthToken.new(payload: { sub: user.id }).token

    {
      'Authorization': "Bearer #{token}"
    }
  end

  describe "GET /users" do
    it "returns 401 unauthorized" do
      get '/users'

      expect(response.status).to eq 401

    end

    it "responds successfully" do
      get '/users', headers: authenticated_header(@user1)

      assert_response :success
    end

  end

  describe "GET /users/:id" do
    it "gets the logged in user" do
      get user_path(@user1), headers: authenticated_header(@user1)

      assert_response :success
    end

    it "does not allow to view other users" do
      get user_path(@user2), headers: authenticated_header(@user1)

      expect(response.status).to eq 401
    end
  end

  describe "DELETE /users/:id" do
    it "deletes the specified user" do
      delete user_path(@user1), headers: authenticated_header(@user1)

      expect(response.status).to eq 204
    end

    it "does not allow deletion of other users" do
      delete user_path(@user2), headers: authenticated_header(@user1)

      expect(response.status).to eq 401
    end
  end
end
