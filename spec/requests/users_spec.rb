require 'rails_helper'

RSpec.describe "Users", :type => :request do
  describe "GET /users" do
    it "returns 401 unauthorized" do
      get '/users'

      expect(response.status).to eq 401

    end
  end
end
