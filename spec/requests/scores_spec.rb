require 'rails_helper'

RSpec.describe 'Scores', :type => :request do
  before :each do
    @course = FactoryGirl.create :course
    @hole1 = FactoryGirl.create :hole, course: @course
    @hole2 = FactoryGirl.create :hole, course: @course, number: 2
    @hole3 = FactoryGirl.create :hole, course: @course, number: 3
    @user1 = FactoryGirl.create :user
    @user2 = FactoryGirl.create :user
    @round = FactoryGirl.create :round, user: @user1, course: @course
    @score1 = FactoryGirl.create :score, user: @user1,
      hole: @hole1,
      round: @round
    @score2 = FactoryGirl.create :score, user: @user1,
      hole: @hole2,
      round: @round,
      strokes: 5
  end

  let(:score) {
    score = {
      data: {
        type: 'scores',
        attributes: {
          strokes: 3
        },
        relationships: {
          user: { data: { type: 'users', id: @user1.id } },
          hole: { data: { type: 'holes', id: @hole3.id } },
          round: { data: { type: 'rounds', id: @round.id } }
        }
      }
    }
  }

  describe 'GET /scores' do
    it 'checks auth' do
      get '/scores'
      assert_response :unauthorized
    end

    it 'gets all of the scores' do
      get '/scores', headers: authenticated_header(@user1)
      assert_response :success

      body = JSON.parse(response.body)
      score1_stroke = body['data'][0]['attributes']['strokes']
      score2_stroke = body['data'][1]['attributes']['strokes']
      expect(score1_stroke).to eq @score1.strokes
      expect(score2_stroke).to eq @score2.strokes
    end
  end

  describe 'GET /scores/:id' do
    it 'checks auth' do
      get score_path(@score1)
      assert_response :unauthorized
    end

    it 'gets the score' do
      get score_path(@score1), headers: authenticated_header(@user1)
      assert_response :success

      body = JSON.parse(response.body)
      score1_stroke = body['data']['attributes']['strokes']
      expect(score1_stroke).to eq @score1.strokes
    end
  end

  describe 'POST /scores' do
    it 'checks auth' do
      post '/scores',
        params: score.to_json,
        headers: { 'Content-Type': 'application/vnd.api+json' }
      assert_response :unauthorized
    end

    it 'creates the score' do
      post '/scores',
        params: score.to_json,
        headers: authenticated_header(@user1)
      expect(response.status).to eq 201
    end

    it 'only allows users to create scores for themselves' do
      score = {
        data: {
          type: 'scores',
          attributes: {
            strokes: 3
          },
          relationships: {
            user: { data: { type: 'users', id: @user2.id } },
            hole: { data: { type: 'holes', id: @hole1.id } },
            round: { data: { type: 'rounds', id: @round.id } }
          }
        }
      }

      post '/scores',
        params: score.to_json,
        headers: authenticated_header(@user1)
      assert_response :unauthorized
    end
  end

  describe 'PUT /scores/:id' do
    it 'updates the score' do
      score = {
        data: {
          type: 'scores',
          id: @score1.id,
          attributes: {
            strokes: 4
          }
        }
      }

      put score_path(@score1),
        params: score.to_json,
        headers: authenticated_header(@user1)

      assert_response :success
    end

    it 'only allows users to update their own scores' do
      score = {
        data: {
          type: 'scores',
          id: @score1.id,
          attributes: {
            strokes: 4
          }
        }
      }

      put score_path(@score1),
        params: score.to_json,
        headers: authenticated_header(@user2)

      assert_response :unauthorized
    end
  end

  describe 'DELETE /scores/:id' do
    it 'deletes the score' do
      delete score_path(@score1), headers: authenticated_header(@user1)
      assert_response :success
    end

    it "does not allow deletion of other users' scores" do
      delete score_path(@score1), headers: authenticated_header(@user2)
      assert_response :unauthorized
    end
  end
end
