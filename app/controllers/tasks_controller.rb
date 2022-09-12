class TasksController < ApplicationController
    
    before_action :set_task, only: [:update, :destroy]

    def create
        @project = Project.find(params[:task][:project_id])
        @task = @project.task.new(task_params)        
        @task[:status] = STATUS[:inativo]
            
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

    def self.calc_task_progress
        @tasks = Task.all
        @tasks.nil? || @tasks.empty? ? 0 : self.calc_percent(@tasks)
    end

    private
    
    def set_task
        @task = Task.find(params[:id])
    end

    def task_params
        params.require(:task).permit(:name, :date_in, :date_end, :checked)
    end

    def self.calc_percent(array)
        checked = 0
        array.each do | task |
            if task[:checked] == true
                checked += 1
            end
        end
        value = ( checked / array.count ) * 100
        value.floor
    end

end
