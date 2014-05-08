class TasksController < ApplicationController

  before_action :find_project

  def create
    @task = @project.tasks.new(task_params)
    if @task.save
      render json: {status: "success", 
                    title: @task.title,
                    url: project_task_path(@project, @task)}
    else
      render json: {status: "failure", errors: @task.errors.full_messages}
    end
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(task_params)
      render json: {status: "success"}
    else
      render json: {status: "failure"}
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :completed)
  end

  def find_project
    @project = Project.find params[:project_id]
  end

end
