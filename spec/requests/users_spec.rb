require 'rails_helper'

RSpec.describe "Users", :type => :request do

  before(:each) do
    @user1 = FactoryGirl.create :user, name: 'Nate Sexton'
    @user2 = FactoryGirl.create :user, name: 'Paul McBeth'
  end

   describe 'GET /users' do
    it 'checks auth' do
      get '/users'

      expect(response.status).to eq 403

    end

    it 'gets all of the users' do
      get '/users', headers: authenticated_header(@user1)

      assert_response :success

      body = JSON.parse(response.body)
      user_names = body['data'].map{|user| user['attributes']['name'] }
      user_ids = body['data'].map{|user| user['id'].to_i }

      expect(user_names).to match_array([@user1.name, @user2.name])
      expect(user_ids).to match_array([@user1.id, @user2.id])
    end
  end

  describe 'GET /users/:id' do
    it 'gets the logged in user' do
      get user_path(@user1), headers: authenticated_header(@user1)

      assert_response :success

      body = JSON.parse(response.body)
      user_name = body['data']['attributes']['name']
      user_id = body['data']['id'].to_i
      user_email = body['data']['attributes']['email']

      expect(user_name).to eq @user1.name
      expect(user_id).to eq @user1.id
      expect(user_email).to eq @user1.email
    end
  end

  describe 'POST /users/' do
    it 'creates the user' do
      user = {
        data: {
          type: 'users',
          attributes: {
            name: 'Philo Brathwaite',
            email: 'albatrossboss@gmail.com',
            password: 'password'
          }
        }
      }

      post '/users',
        params: user.to_json,
        headers: { 'Content-Type': 'application/vnd.api+json' }

      expect(response.status).to eq 201

      body = JSON.parse(response.body)
      user_name = body['data']['attributes']['name']
      expect(user_name).to eq 'Philo Brathwaite'
    end
  end

  describe 'PUT /users/:id' do
    it 'updates the user' do
      user = {
        data: {
          type: 'users',
          id: @user1.id,
          attributes: {
            name: 'Nathan Sexton'
          }
        }
      }

      put user_path(@user1),
        params: user.to_json,
        headers: authenticated_header(@user1)

      expect(response.status).to eq 200
    end

    it 'does not allow updating of other users' do
      user = {
        data: {
          type: 'users',
          id: @user2.id,
          attributes: {
            name: 'Donald Trump'
          }
        }
      }

      put user_path(@user2),
        params: user.to_json,
        headers: authenticated_header(@user1)

      expect(response.status).to eq 403
    end
  end

  describe 'DELETE /users/:id' do
    it 'deletes the specified user' do
      delete user_path(@user1), headers: authenticated_header(@user1)

      expect(response.status).to eq 204
    end

    it 'does not allow deletion of other users' do
      delete user_path(@user2), headers: authenticated_header(@user1)

      expect(response.status).to eq 403
    end
  end
end
