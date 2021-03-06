class ApplicationController < ActionController::Base
  # before_action :basic_auth

  # def basic_auth
  #   authenticate_or_request_with_http_basic do |username, password|
  #     username == 'test' && password == '1234'
  #   end
  # end

  add_flash_types :success, :info, :warning, :danger
  
  protect_from_forgery with: :exception
  include SessionsHelper

  def authenticate_user
    if current_user == nil
      flash[:danger] = "ログインが必要です。"
      redirect_to new_session_path
    end
  end
end
