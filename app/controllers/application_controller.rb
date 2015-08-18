class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  #methods are in default available only to controller
  #To allow methods in views, use helper_method:
  
  helper_method :current_user, :logged_in?
  
  
  def current_user
    @current_user ||= Chef.find(session[:chef_id]) if session[:chef_id]
  end
  
  def logged_in?
    #remember, !!current_user points to the method, not the variable @current user!
    !!current_user
    
    #Wrong return
    #!!@current_user
  end
  
  def require_user
    if !logged_in? 
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
    end
  end
  
  def require_user_like
    if !logged_in? 
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to :back
    end
  end
  
  
  
end
