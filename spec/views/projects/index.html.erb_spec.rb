require 'rails_helper'

RSpec.describe "projects/index", type: :view do
    before(:each) do
        view.extend ProjectsHelper        
    end

    context "index helpers" do
        let(:project) { create(:project, :with_task) }        
        it "return delayed string" do
            expect(get_color(project)).to eq(" delayed")
        end
        it "return checked string" do
            project = create(:project, :with_checked_task)
            expect(get_color(project)).to eq("checked")
        end
        it "calc project progress should return 0" do
            expect(calculate_project_progress(project)).to eq(0)
        end
        it "calc project progress should return 100" do
            project = create(:project, :with_checked_task)
            expect(calculate_project_progress(project)).to eq(100)
        end
    end
end
