class TasksController < ApplicationController
  before_action :authenticate_user! , only: [:new]
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
    @notes = @task.notes
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user = current_user
    if @task.save
      redirect_to tasks_path
    else
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    @task.update(task_params)

    redirect_to tasks_path, notice: "Update Success"
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:alert] = "Task deleted"
    redirect_to tasks_path
  end

  private

  def task_params
    params.require(:task).permit(:title, :description)
  end
end
