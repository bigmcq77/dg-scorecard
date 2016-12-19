require 'rails_helper'

RSpec.describe 'Holes', :type => :request do
  before :each do
    @course = FactoryGirl.create :course
    @hole1 = FactoryGirl.create :hole
    @hole2 = FactoryGirl.create :hole, number: 2
    @user1 = FactoryGirl.create :user, name: 'Nate Sexton'
  end

  def authenticated_header(user)
    token = Knock::AuthToken.new(payload: { sub: user.id }).token

    {
      'Content-Type': 'application/vnd.api+json',
      'Authorization': "Bearer #{token}"
    }
  end

  describe 'GET /holes' do
    it 'checks auth' do
      get '/holes'
      assert_response :unauthorized
    end

    it 'gets all of the holes' do
      get '/holes', headers: authenticated_header(@user1)
      assert_response :success

      body = JSON.parse(response.body)
      hole_numbers = body['data'].map{|hole| hole['attributes']['number'].to_i }
      hole_ids = body['data'].map{|hole| hole['id'].to_i }

      expect(hole_numbers).to match_array([@hole1.number, @hole2.number])
      expect(hole_ids).to match_array([@hole1.id, @hole2.id])
    end
  end

  describe 'GET /holes/:id' do
    it 'gets the hole' do
      get hole_path(@hole1), headers: authenticated_header(@user1)
      assert_response :success

      body = JSON.parse(response.body)
      hole_number = body['data']['attributes']['number']
      hole_id = body['data']['id'].to_i

      expect(hole_number).to eq @hole1.number
      expect(hole_id).to eq @hole1.id
    end
  end

  describe 'GET /holes/:id/?include=course' do
    it 'includes the course information' do
      get hole_path(@hole1) + "?include=course",
        headers: authenticated_header(@user1)
      assert_response :success

      body = JSON.parse(response.body)
      course_name = body['included'][0]['attributes']['name']
      course_holes = body['included'][0]['attributes']['num-holes']
      expect(course_name).to eq @hole1.course.name
      expect(course_holes).to eq @hole1.course.num_holes
    end
  end

  describe 'POST /holes/' do
    it 'creates the hole' do
      hole = {
        data: {
          type: 'holes',
          attributes: {
            number: 1,
            par: 4,
            'course-id': @course.id
          }
        }
      }

      post '/holes',
        params: hole.to_json,
        headers: authenticated_header(@user1)
      expect(response.status).to eq 201
    end

    it 'checks auth' do
      post '/holes',
        headers: { 'Content-Type': 'application/vnd.api+json' }
      assert_response :unauthorized
    end
  end

  describe 'PUT /holes/:id' do
    it 'updates the hole' do
      hole = {
        data: {
          type: 'holes',
          id: @hole1.id,
          attributes: {
            par: @hole1.par+1
          }
        }
      }

      put hole_path(@hole1),
        params: hole.to_json,
        headers: authenticated_header(@user1)
      body = JSON.parse(response.body)
      par = body['data']['attributes']['par'].to_i
      expect(response.status).to eq 200
      expect(par).to eq @hole1.par+1
    end

    it 'checks auth' do
      put hole_path(@hole1),
        headers: { 'Content-Type': 'application/vnd.api+json' }
      assert_response :unauthorized
    end
  end

  describe 'DELETE /holes/:id' do
    it 'deletes the hole' do
      delete hole_path(@hole1), headers: authenticated_header(@user1)
      expect(response.status).to eq 204
    end

    it 'checks auth' do
      delete hole_path(@hole1),
        headers: { 'Content-Type': 'application/vnd.api+json' }
      assert_response :unauthorized
    end
  end
end

