class ProjectsController < ApplicationController

    before_action :set_project, only: [:update, :destroy]
    before_action :new, only: [:index]

    def index
        @projects = Project.all
        @task_progress = TasksController::calc_progress
        @project_progress = calc_total_project_progress(@projects)        
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
        if project.task.empty?
            return ""
        end
        completed = isCompleted(project.task)
        delayed = project.task.select{|task| isDelayed(task[:date_end], project[:date_end]) }
        if completed
            return "checked"
        end
        !delayed.empty? ? " delayed" : ""
    end

    private
    
    def set_project
        @project = Project.find(params[:id])
    end

    def project_params
        params.require(:project).permit(:name, :date_in, :date_end)
    end

    def calc_total_project_progress(projects)    
        if projects.empty?
            return 0
        end
        completed = 0
        projects.each do | value |
            if isCompleted(value.task)
                completed += 1
            end
        end
        value = ( completed.to_f / projects.count.to_f ) * 100
        value.floor
    end

    def isCompleted(tasks)
        checked_list = tasks.select { |value| value[:checked] == false }
        !tasks.empty? && checked_list.empty?
    end

    def isDelayed date, compare
        date > compare
    end

end
