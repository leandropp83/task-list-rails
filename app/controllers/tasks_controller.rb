class TasksController < ApplicationController
    
    before_action :set_task, only: [:update, :destroy]

    def create
        @project = Project.find(params[:task][:project_id])
        @task = @project.task.new(task_params)
        @task = task_service.get_other_params @task        
        if @task.save
            flash[:notice] = "#{@task[:name]} foi cadastrado!"
        else
            flash[:error] = @task.errors.full_messages              
        end
        redirect_to root_path
    end

    def destroy
        @task.destroy
        flash[:notice] = "#{@task[:name]} foi removido!"
        redirect_to root_path
    end

    def update
        respond_to do |format|
            if @task.update(task_params)
                format.html { redirect_to root_path, flash: { notice: "#{@task[:name]} foi atualizado!"} }
                format.json { render json: @task, status: :created }
            else
                format.html { redirect_to root_path, flash: { error: @task.errors.full_messages } }
                format.json { render json: @task.errors, status: :unprocessable_entity }
            end
        end        
    end

    def task_repository
        @task_repository ||= Application::Repository::TaskRepository.new    
    end

    def task_service
        @task_service ||= Application::Services::TaskService.new
    end

    private
    
    def set_task
        @task = task_repository.set_task(params[:id])
    end

    def task_params
        params.require(:task).permit(:name, :date_in, :date_end, :checked)
    end

end
