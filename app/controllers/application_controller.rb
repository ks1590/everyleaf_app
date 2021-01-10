class ApplicationController < ActionController::Base
  before_action :basic_auth

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == 'test' && password == '1234'
    end
  end
end
