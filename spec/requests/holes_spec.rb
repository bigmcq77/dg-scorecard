require 'rails_helper'

RSpec.describe "Holes", type: :request do
  describe "GET /holes" do
    it "works! (now write some real specs)" do
      get holes_path
      expect(response).to have_http_status(200)
    end
  end
end
