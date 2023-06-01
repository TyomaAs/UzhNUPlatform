# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
	before_action :redirect_if_authenticated, only: [:create, :new]
 
	def create
	  @user = User.find_by(email: params[:user][:email].downcase)
	  if @user
		 if @user.authenticate(params[:user][:password])
			login @user
			redirect_to home_path, notice: "Signed in."
		 else
			flash.now[:alert] = "Incorrect email or password."
			render :new, status: :unprocessable_entity
		 end
	  else
		 flash.now[:alert] = "Incorrect email or password."
		 render :new, status: :unprocessable_entity
	  end
	end
 
	def destroy
	  logout
	end
 
	def new
	end
 
end
 