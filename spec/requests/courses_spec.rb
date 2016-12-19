require 'rails_helper'

RSpec.describe 'Courses', :type => :request do

  before :each do
    @course1 = FactoryGirl.create :course
    @course2 = FactoryGirl.create :course, name: 'Creve Coeur', num_holes: 18
    @user1 = FactoryGirl.create :user, name: 'Nate Sexton'
    @user2 = FactoryGirl.create :user, name: 'Paul McBeth'
  end

    describe 'GET /courses' do
    it 'returns 401 unauthorized' do
      get '/courses'
      expect(response.status).to eq 401
    end

    it 'gets all of the courses' do
      get '/courses', headers: authenticated_header(@user1)
      assert_response :success

      body = JSON.parse(response.body)
      course_names = body['data'].map{|course| course['attributes']['name'] }
      course_ids = body['data'].map{|course| course['id'].to_i }

      expect(course_names).to match_array([@course1.name, @course2.name])
      expect(course_ids).to match_array([@course1.id, @course2.id])
    end
  end

  describe 'GET /courses/:id' do
    it 'gets the course' do
      get course_path(@course1), headers: authenticated_header(@user1)
      assert_response :success

      body = JSON.parse(response.body)
      course_name = body['data']['attributes']['name']
      course_id = body['data']['id'].to_i
      course_holes = body['data']['attributes']['num-holes'].to_i

      expect(course_name).to eq @course1.name
      expect(course_id).to eq @course1.id
      expect(course_holes).to eq @course1.num_holes
    end
  end

  describe 'POST /courses/' do
    it 'creates the course' do
      course = {
        data: {
          type: 'courses',
          attributes: {
            name: "Lion's Club",
            'num-holes': 18
          }
        }
      }

      post '/courses',
        params: course.to_json,
        headers: authenticated_header(@user1)
      expect(response.status).to eq 201
    end

    it 'checks auth' do
      post '/courses',
        headers: { 'Content-Type': 'application/vnd.api+json' }
      assert_response :unauthorized
    end
  end

  describe 'PUT /courses/:id' do
    it 'updates the course' do
      course = {
        data: {
          type: 'courses',
          id: @course1.id,
          attributes: {
            'num-holes': 18
          }
        }
      }

      put course_path(@course1),
        params: course.to_json,
        headers: authenticated_header(@user1)
      body = JSON.parse(response.body)
      num_holes = body['data']['attributes']['num-holes'].to_i

      expect(response.status).to eq 200
      expect(num_holes).to eq 18
    end

    it 'checks auth' do
       put course_path(@course1),
         headers: { 'Content-Type': 'application/vnd.api+json' }
       assert_response :unauthorized
    end
  end

  describe 'DELETE /courses/:id' do
    it 'deletes the course' do
      delete course_path(@course1), headers: authenticated_header(@user1)
      expect(response.status).to eq 204
    end

    it 'checks auth' do
      delete course_path(@course1),
        headers: { 'Content-Type': 'application/vnd.api+json' }
      assert_response :unauthorized
    end
  end
end
