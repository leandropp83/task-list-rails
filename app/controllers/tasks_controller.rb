class TasksController < ApplicationController

    def create

        @project = Project.find(params[:task][:project_id])
        @task = @project.task.new(task_params)        
        @task[:status] = STATUS[:ativo]
            
        if @task.save
            flash[:notice] = "#{@task[:name]} foi cadastrado!"
        else
            flash[:error] = @task.errors.full_messages              
        end
        redirect_to root_path
      end

    private
    
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
        params.require(:task).permit(:name, :date_in, :date_end, :checked)
    end

end
