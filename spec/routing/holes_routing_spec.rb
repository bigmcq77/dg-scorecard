require "rails_helper"

RSpec.describe HolesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/holes").to route_to("holes#index")
    end

    it "routes to #new" do
      expect(:get => "/holes/new").to route_to("holes#new")
    end

    it "routes to #show" do
      expect(:get => "/holes/1").to route_to("holes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/holes/1/edit").to route_to("holes#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/holes").to route_to("holes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/holes/1").to route_to("holes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/holes/1").to route_to("holes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/holes/1").to route_to("holes#destroy", :id => "1")
    end

  end
end
