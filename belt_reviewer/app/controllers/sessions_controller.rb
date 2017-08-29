class SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def create    # Log the user in
    user = User.find_by_email(params[:user][:email]).try(:authenticate, params[:user][:password])
    if user
      login_user(user)                 # Log the user in if authenticated
    else
      flash['alert-danger'] = ['Please try again or register an account.']
      redirect_to new_user_path         # Send the user back after no success
    end
  end

  def destroy   # Log the user out
    reset_session                       # Erase the session data
    flash['alert-success'] = ['You have successfully logged out.']
    redirect_to new_user_path           # Send back to login/register page
  end
end
