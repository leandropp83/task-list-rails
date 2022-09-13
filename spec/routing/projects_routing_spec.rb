require "rails_helper"

RSpec.describe ProjectsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
        expect(get: "/").to route_to("projects#index")
    end

    it "routes to #create" do
      expect(post: "/projects").to route_to("projects#create")
    end

    it "routes to #update via PUT" do
        expect(put: "/projects").to route_to("projects#update")
    end

    it "routes to #destroy" do
        expect(get: "/projects/1/destroy").to route_to("projects#destroy", id: "1")
    end
  end
end
