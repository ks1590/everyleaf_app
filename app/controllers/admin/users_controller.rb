class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:edit, :show]
  before_action :require_admin

  PREVIEW = 5

  def index
    @users = User.all.order(id: "ASC")
  end

  def new
      @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_user_path(@user.id), notice:"ユーザー:#{@user.name}を登録しました"
    else
      render :new
    end
  end

  def edit
  end

  def show
    @tasks = @user.tasks
    @tasks = @tasks.page(params[:page]).per(PREVIEW)
  end

  private
  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation,
      :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_admin
    unless current_user.admin?
      flash[:warning] = "権限が無いためアクセスできません"
      redirect_to tasks_path
    end
  end
end