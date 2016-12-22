require 'rails_helper'

RSpec.describe 'Rounds', :type => :request do
  before :each do
    @course = FactoryGirl.create :course
    @user1 = FactoryGirl.create :user
    @user2 = FactoryGirl.create :user
    @round = FactoryGirl.create :round, user: @user1, course: @course
  end

  let(:round) {
    round = {
      data: {
        type: 'rounds',
        attributes: {
          weather: 'Cloudy'
        },
        relationships: {
          user: { data: { type: 'users', id: @user1.id } },
          course: { data: { type: 'courses', id: @course.id } }
        }
      }
    }

  }

  describe 'GET /rounds' do
    it 'checks auth' do
      get '/rounds'
      assert_response :unauthorized
    end

    it 'gets all of the rounds' do
      get '/rounds', headers: authenticated_header(@user1)
      assert_response :success

      body = JSON.parse(response.body)
      weather = body['data'][0]['attributes']['weather']
      expect(weather).to eq @round.weather
    end
  end

  describe 'GET /rounds/:id' do
    it 'gets the round' do
      get round_path(@round), headers: authenticated_header(@user1)
      assert_response :success

      body = JSON.parse(response.body)
      weather = body['data']['attributes']['weather']
      expect(weather).to eq @round.weather
    end
  end

  describe 'POST /rounds' do
    it 'creates the round' do

      post '/rounds',
        params: round.to_json,
        headers: authenticated_header(@user1)
      expect(response.status).to eq 201
    end

    it 'checks auth' do
      post '/rounds',
        params: round.to_json,
        headers: { 'Content-Type': 'application/vnd.api+json' }
      assert_response :unauthorized
    end

    it 'only allows users to create rounds for themselves' do
      round = {
        data: {
          type: 'rounds',
          attributes: {
            weather: 'Cloudy'
          },
          relationships: {
            user: { data: { type: 'users', id: @user2.id } },
            course: { data: { type: 'courses', id: @course.id } }
          }
        }
      }

      post '/rounds',
        params: round.to_json,
        headers: authenticated_header(@user1)
      expect(response.status).to eq 401
    end
  end

  describe 'PUT /rounds/:id' do
    it 'updates the round' do
      round = {
        data: {
          type: 'rounds',
          id: @round.id,
          attributes: {
            weather: 'Rainy'
          }
        }
      }

      put round_path(@round),
        params: round.to_json,
        headers: authenticated_header(@user1)

      expect(response.status).to eq 200
    end
  end
end
