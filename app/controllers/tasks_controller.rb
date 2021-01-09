class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
    @task.deadline = Date.today
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: "タスクを登録しました。"
    else
      render :new
    end
  end
  
  def edit
  end

  def show
  end

  private
  def task_params
    params.require(:task).permit(
      :title,
      :detail,
      :deadline,
      :priority,
      :status
    ) 
  end
  
end
