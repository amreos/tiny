class UsersController < ApplicationController
skip_before_action :require_valid_user!, except: [:destroy]
before_action :reset_session

	def show
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if@user.save
			session[:user_id] = @user.id
			flash[:success] = "Welcome to the Sample App!"
			redirect_to user_path(@user);
		else
			render 'new'
		end
	end

	private

		def user_params
	      params.require(:user).permit(:name, :email, :password,
	                                   :password_confirmation)
	    end
end
