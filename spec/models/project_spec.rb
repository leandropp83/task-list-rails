require 'rails_helper'

RSpec.describe Project, type: :model do
    let(:project) { create(:project) }
    it "name is invalid if too short" do
        project[:name] = 'cd'
        expect(project).to_not be_valid
    end
    it "should be valid" do
        expect(project).to be_valid
    end
    it "fail if project name not be unique" do
        create(:project, name: "abcde")
        expect{ create(:project, name: "abcde") }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Name has already been taken")
    end
end
