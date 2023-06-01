class CoursesController < ApplicationController
	before_action :redirect_if_not_authenticated, only: [:create, :new, :index, :show, :destroy, :edit]
	def index
		 @courses = Course.all
	end    
	def show
		 @course = Course.find(params[:id])
		 @post = Post.all
		 @task = Task.all

	end
	def new
		 @course = Course.new
	end
	def create
		 @course = current_user.courses.create(name: course_params[:name])
		 
		 if(@course.save)
			  redirect_to @course
		 else
			  render 'new'
		 end
	end

	def edit
		@course = Course.find(params[:id])
	end
	
	def update
		@course = Course.find(params[:id])
		if @course.update(course_params)
			redirect_to @course, notice: 'Курс успішно оновлено.'
		else
		  render :edit
		end
	end
	def destroy
		@course = Course.find(params[:id])
		@course.destroy
		redirect_to home_path, notice: 'Курс був успішно видалений'
	end
	private def course_params
      params.require(:course).permit(:name)
    end
end
