require 'rails_helper'

RSpec.describe TasksController, type: :controller do

    context ".calculate_progress" do
        it "empty tasks should return 0" do
            [{}, nil, ""].each do | arg |
                expect(Application::Services::TaskService.new.calculate_progress arg).to eq(0)
            end
        end
        it "should return 100%" do
            projects = create_list(:project, 2, :with_checked_task)
            projects.each do | project |
                expect(Application::Services::TaskService.new.calculate_progress project.task).to eq(100)
            end            
        end
    end

    context "GET #destroy" do
        let!(:task) { create(:task) }
        it "deletes task" do                      
            expect { task.destroy }.to change { Task.count }.by(-1)
        end
    end

    context "POST #create" do
        let(:project) { create(:project) }
        let!(:params) { {
                name: "Teste",
                checked: STATUS[:inativo],
                date_in: '12/10/2030',
                date_end: '10/10/2032',
                project_id: project.id
            } } 
        it "fail to create a new task - date_end should be > date_in" do    
            params[:date_end] = '10/10/2020'
            post :create, params: { task: params }
            expect(flash[:error]).to eq(["Date end  deve ser maior que a data inicial"]) 
        end
        it "create a new task" do
            post :create, params: { task: params }
            expect(flash[:notice]).to eq("#{params[:name]} foi cadastrado!") 
        end        
    end

    context "PUT #update" do
        let!(:task) { create(:task) }
        it "update task name" do
            params = { name: "Novo nome" } 
            put :update, params: { id: task.id, task: params }
            task.reload
            expect(task.name).to eq(params[:name])
            expect(flash[:notice]).to eq("#{params[:name]} foi atualizado!") 
        end
        it "fail to update task name" do
            params = { name: nil } 
            put :update, params: { id: task.id, task: params }
            task.reload
            expect(task.name).to_not eq(params[:name])
            expect(flash[:error]).to eq(["Name can't be blank", "Name is too short (minimum is 3 characters)"]) 
        end
    end

end