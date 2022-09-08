class ProjectsController < ApplicationController

  before_action :set_project, only: [:update, :destroy]
  before_action :new, only: [:index]
  # protect_from_forgery unless: -> { request.format.json? }

  def index
    @projects = Project.all
    # raise @projects.inspect
    @progress = 0
    @project_progress = 0
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project[:status] = STATUS[:ativo]
    respond_to do |format|
      if @project.save
        format.html do
          flash[:notice] = "Projeto cadastrado!"
          redirect_to '/'
        end
        format.json { render :index, status: :created, location: @project }
      else
        format.html do
          flash[:error] = @project.errors.full_messages
          redirect_to '/'
        end
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  end

  def update
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
