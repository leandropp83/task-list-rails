require 'rails_helper'

RSpec.describe Task, type: :model do
    let(:project) { create(:project, :with_task) }
    it "name is invalid if too short" do
        project.task[0][:name] = 'ab'
        expect(project.task[0]).to_not be_valid
    end
    it "should be valid" do
        expect(project.task[0]).to be_valid
    end
    it "project date_in can't be greatest than task date" do
        project.task[0][:date_in] = '10/10/2012'
        expect(project.task[0]).to_not be_valid
    end
end
