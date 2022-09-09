class ProjectsController < ApplicationController

  before_action :set_project, only: [:update, :destroy]
  before_action :new, only: [:index]

  def index
    @projects = Project.all
    @progress = 0
    @project_progress = 0
  end

  def new
    @project = Project.new
    @task = Task.new
  end

  def create
    @project = Project.new(project_params)
    @project[:status] = STATUS[:ativo]
    respond_to do |format|
      if @project.save
        format.html do
          flash[:notice] = "#{@project[:name]} foi cadastrado!"
          redirect_to root_path
        end
        format.json { render :index, status: :created, location: @project }
      else
        format.html do
          flash[:error] = @project.errors.full_messages
          redirect_to root_path
        end
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
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

  private
    
    def set_project
      @project = Project.find(params[:id])
    end

    def project_params
      # raise params.inspect
      params.require(:project).permit(:name, :date_in, :date_end)
    end

end
