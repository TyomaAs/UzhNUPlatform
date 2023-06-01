# app/controllers/users_controller.rb
class UsersController < ApplicationController
	before_action :redirect_if_not_authenticated, only: [:create, :new, :index] #

	def new
	  @user = User.new
	end
 
	def create
		@user = User.new(user_params)
		if @user.save
		  redirect_to users_path, notice: 'User was successfully created.'
		else
		  render :new
		end
	end
	 
 
	def index
		@users = User.all
	end
	 
	def show
		@user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
	end
	
	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			redirect_to user_path(@user), notice: 'User was successfully updated.'
		else
			render :edit
		end
	end
	
	def destroy
		@user = User.find(params[:id])
		@user.destroy
		redirect_to users_path
	end

	private

	def user_params
	  params.require(:user).permit(:name, :faculty, :email, :password, :role)
	end

	def authenticate_admin!
		unless current_user && current_user.role == "admin"
		  redirect_to root_url, alert: 'You are not authorized to perform this action.'
		end
	end
end
