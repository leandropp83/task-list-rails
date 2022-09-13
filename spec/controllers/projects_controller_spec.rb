require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
    context "GET #index" do
        it "should render index page" do
            get :index
            expect(response).to have_http_status(200)
            expect(response).to render_template(:index)
        end
        it "projects should be empty" do
            get :index
            expect(assigns(:projects)).to be_empty
        end
        it "should have one project" do
            create(:project)
            get :index
            expect(assigns(:projects)).to_not be_empty
        end        
    end

    context ".new" do        
        it "should have a new project" do
            get :index
            expect(assigns(:project)).to be_a_new(Project) 
        end        
    end

    context "GET #destroy" do
        let(:project) { create(:project) } 
        it "find project by id" do          
            get :destroy, params: {id: project.id}
            expect(assigns(:project)).to be_a(Project) 
        end
        xit "deletes project" do                      
            expect do
                get destroy_projects_path(project)
            end.to change(Project, :count).by(-1) 
        end
    end

    context "POST #create" do
        let!(:params) { {name: "Teste", date_in: '12/10/2021', date_end: '10/10/2022'} } 
        it "fail to create a new project - date_end should be > date_in" do    
            params[:date_end] = '10/10/2020'
            post :create, params: { project: params }
            expect(flash[:error]).to eq(["Date end  deve ser maior que a data inicial"]) 
        end
        it "create a new project" do
            post :create, params: { project: params }
            expect(flash[:notice]).to eq("#{params[:name]} foi cadastrado!") 
        end        
    end

    context "PUT #update" do
        let!(:project) { create(:project) }
        it "update project name" do
            params = { name: "Novo nome" } 
            put :update, params: { id: project.id, project: params }
            project.reload
            expect(project.name).to eq(params[:name])
            expect(flash[:notice]).to eq("#{params[:name]} foi atualizado!") 
        end
        it "fail to update project name" do
            params = { name: nil } 
            put :update, params: { id: project.id, project: params }
            project.reload
            expect(project.name).to_not eq(params[:name])
            expect(flash[:error]).to eq(["Name can't be blank", "Name is too short (minimum is 3 characters)"]) 
        end
    end

end