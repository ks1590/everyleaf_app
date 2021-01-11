class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :show, :destroy]
  
  def index
    @tasks = Task.all
    if params[:sort_expired]
      @tasks = @tasks.deadline
    elsif params[:sort_priority]
      @tasks = @tasks.priority
    else
      @tasks = @tasks.default
    end
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

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを更新しました。"
    else
      flash[:danger] = "タスクの更新に失敗しました。"
      render :edit
    end
  end
  
  def show
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "タスクを削除しました。"
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
  
  def set_task
    @task = Task.find(params[:id])    
  end
end
