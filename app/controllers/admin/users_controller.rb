class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy, :show]
  before_action :require_admin

  PREVIEW = 5

  def index
    @users = User.select(:id, :name, :email, :admin).order(created_at: :asc).page(params[:page]).per(PREVIEW)
  end

  def new
      @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_user_path(@user.id), notice:"ユーザー:#{@user.name}を登録しました"
    else
      flash.now[:danger] = "ユーザー登録に失敗しました"
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "#{@user.name}の登録内容を更新しました。"
      redirect_to admin_user_path(@user)
    else
      flash.now[:warning] = "#{@user.name}の登録内容を更新できませんでした。"
      render :edit
    end
  end  

  def show
    @tasks = @user.tasks
    @tasks = @tasks.page(params[:page]).per(PREVIEW)
  end

  def destroy
    if @user.destroy
      flash[:danger] = "#{@user.name}さんのデータを削除しました"
      redirect_to admin_users_path
    else
      flash[:info] = '管理者権限ユーザーは最低でも１人必要です。'
      redirect_to admin_users_path
    end
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