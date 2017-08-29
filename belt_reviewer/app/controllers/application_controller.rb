class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :login_user
  before_action :require_login

  # Helper to log user into session
  def login_user(user)
    session['id'] = user.id
    flash['alert-success'] = ['You have successfully logged in.']
    redirect_to events_path    # Send to products page
  end

  # Helper to grab user info in controllers
  def current_user
    User.find(session[:id]) if session[:id]
  end

  # Login controller filter to restrict access to logged in users
  def require_login
    unless session[:id]
      flash['alert-danger'] = ["You must be logged in to continue."]
      redirect_to new_user_path
    end
  end

  # Ensure current user access only their own routes
  def authorize_current_user
    if current_user != User.find(params[:id])
      flash['alert-danger'] = ["You do not have access to that page."]
      redirect_to events_path
    end
  end
end
