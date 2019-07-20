class ApplicationController < ActionController::Base
  before_action :http_authenticate

  def http_authenticate
    return true unless Rails.env == 'production'
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.credentials.basic_auth_username &&
          password == Rails.application.credentials.basic_auth_password
    end
  end
end
