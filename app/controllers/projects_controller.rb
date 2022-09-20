class ProjectsController < ApplicationController
    
    before_action :set_project, only: [:update, :destroy]
    before_action :new, only: [:index]
    
    include Filter

    def index
        @projects = project_repository.get_projects
        @task_progress = TasksController::calculate_progress
        @project_progress = project_service.calculate_total_project_progress        
    end

    def new
        @project = Project.new
        @task = Task.new
    end

    def create
        @project = Project.new(project_params)
        @project[:status] = STATUS[:ativo]    
        if @project.save
            flash[:notice] = "#{@project[:name]} foi cadastrado!"        
        else
            flash[:error] = @project.errors.full_messages        
        end
        redirect_to root_path
    end

    def destroy
        @project.destroy
        flash[:notice] = "#{@project[:name]} foi removido!"
        redirect_to root_path
    end

    def update
        if @project.update(project_params)
            flash[:notice] = "#{@project[:name]} foi atualizado!"
        else
            flash[:error] = @project.errors.full_messages
        end
        redirect_to root_path
    end

    def get_project_color project
        project_service.get_project_color project
    end

    private

    def project_repository
        @project_repository ||= Application::Repository::ProjectRepository.new order, current_page    
    end

    def project_service
        @project_service ||= Application::Services::ProjectService.new @projects
    end
    
    def set_project
        @project = project_repository.set_project(params[:id])
    end

    def project_params
        params.require(:project).permit(:name, :date_in, :date_end)
    end   

end
