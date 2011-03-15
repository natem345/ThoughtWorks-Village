class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  
  def authenticate
    authenticate_or_request_with_http_basic do |email, password|
      email == [:user][:email] && password == [:user][:password]
    end
    puts "Here I am"
  end
end
