class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  private

  def current_user
    if session[:user_id]
      if session[:user_type] == 'User'
        @current_user ||= User.find_by(id: session[:user_id])
      elsif session[:user_type] == 'Admin'
        @current_user ||= Admin.find_by(id: session[:user_id])
      end
    end
  end

  def logged_in?
    !!current_user
  end

  def require_login
    unless logged_in?
      flash[:alert] = "You must be logged in to access this section"
      redirect_to login_path
    end
  end

  def require_admin
    unless logged_in? && current_user.is_a?(Admin)
      flash[:alert] = "You must be an admin to access this section"
      redirect_to root_path
    end
  end
end
