class SessionController < ApplicationController

include SessionHelper
skip_before_action :require_valid_user!, except: [:logout]

  def create
    reset_session
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:success] = 'Succesful login'
      redirect_to root_path
    else
      flash[:error] = 'Invalid email/password combination'
      redirect_to login_path
    end
  end

  def destroy
    session.delete(:user_id)
    @current_user = nil
    redirect_to root_path
  end

end
