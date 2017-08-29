class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :authorize_current_user, except: [:new, :create]
  layout "two_column"

  def new   # Render login/registration page (also root)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login_user(@user)             # Automatically log user in after registration
    else
      flash['alert-danger'] = @user.errors.full_messages
      redirect_to new_user_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = current_user
    if @user.update(update_params)    # Update user with new info
      flash['alert-success'] = ['User info successfully updated.']
      redirect_to @user
    else
      flash['alert-danger'] = @user.errors.full_messages
      redirect_to edit_user_path(@user)
    end
  end

  def show
  end

  private
    def user_params   # Ensure inputs are the expected fields
      params.require(:user).permit(:first_name, :last_name, :email, :address, :state, :password, :password_confirmation)
    end
    def update_params
      params.require(:user).permit(:first_name, :last_name, :email, :address, :state)
    end
end
