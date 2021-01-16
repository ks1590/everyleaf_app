class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :show, :destroy]
  
  PREVIEW = 5

  def index
    @get_params = get_task_params
    @tasks = Task.search(@get_params)
    if params[:sort_expired]
      @tasks = @tasks.deadline.page(params[:page]).per(PREVIEW)
    elsif params[:sort_priority]
      @tasks = @tasks.priority.page(params[:page]).per(PREVIEW)
    else
      @tasks = @tasks.default.page(params[:page]).per(PREVIEW)
    end
  end

  def new
    @task = Task.new
    @task.deadline = Date.today
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, success: "新しいタスクを登録しました"
    else
      render :new
    end
  end
  
  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, info: "タスク（#{@task.title}）を更新しました"
    else
      flash[:danger] = "タスク（#{@task.title}）の更新に失敗しました"
      render :edit
    end
  end
  
  def show
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, danger: "タスク（#{@task.title}）を削除しました"
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

  def get_task_params
    params.fetch(:search, {}).permit(:title, :status)
  end
end
