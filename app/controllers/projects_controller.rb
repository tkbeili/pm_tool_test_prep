class ProjectsController < ApplicationController
  before_action :find_project, only: [:edit, :show, :update, :destroy]

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to @project, notice: "Project created."
    else
      render :new
    end
  end

  def edit
  end

  def show
    @pending_tasks   = @project.tasks.pending
    @completed_tasks = @project.tasks.completed
  end

  def update
    if @project.update_attributes(project_params)
      redirect_to @project, notice: "Project updated"
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path, notice: "Project deleted"
  end

  private

  def project_params
    params.require(:project).permit(:title, :description)
  end

  def find_project
    @project = Project.find(params[:id])
  end

end
