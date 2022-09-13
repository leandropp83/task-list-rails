require "rails_helper"

RSpec.describe ProjectsController, type: :routing do
  describe "routing" do
    it "routes to #create" do
      expect(post: "/tasks").to route_to("tasks#create")
    end

    it "routes to #update via PUT" do
        expect(put: "/tasks").to route_to("tasks#update")
    end

    it "routes to #update checked via POST" do
        expect(post: "tasks/1/check").to route_to("tasks#update", id: "1", method: :update)
    end

    it "routes to #destroy" do
        expect(get: "/tasks/1/destroy").to route_to("tasks#destroy", id: "1")
    end
  end
end
