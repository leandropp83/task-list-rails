class ProjectsController < ApplicationController

  before_action :set_project, only: [:update, :destroy]

  def index
    @projects = Project.all
    @progress = 0
    @project_progress = 0
  end

  def create
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
      params.require(:project).permit(:name, :date_in, :date_end)
    end

end
