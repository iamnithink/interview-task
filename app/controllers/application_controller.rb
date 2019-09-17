class ApplicationController < ActionController::Base
	protect_from_forgery
  helper_method :current_user

  def authenticate_user
    if session[:user_id]
      # set current user object to @current_user object variable
     @current_user = User.find session[:user_id] 
     return true	
    else
     redirect_to root_path
     return false
   end
  end

	private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
