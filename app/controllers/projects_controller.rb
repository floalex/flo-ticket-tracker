class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:show, :index]
  
  def index
    # display the Projects index to avoid any N+1 queries
    @projects = Project.includes(:tickets)
  end
  
  def show
  end
  
  def new
    @project = Project.new
  end
  
  def create
    @project = Project.new(project_params)
    
    if @project.save
      redirect_to @project
      flash[:success] = "Project was successfully created."
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @project.update(project_params)
      redirect_to @project
      flash[:success] = "Project was successfully updated.."
    else
      render :edit
    end
  end
  
  def destroy
    @project.destroy
    redirect_to projects_path
    flash[:success] = "Project was successfully deleted."
  end
  
  private 
  
  def set_project
    @project = Project.find(params[:id])
  end
  
  def project_params
    params.require(:project).permit(:name, :description)
  end
end