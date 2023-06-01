class TasksController < ApplicationController
	before_action :redirect_if_not_authenticated, only: [:create, :new, :index, :show, :destroy, :edit]
	def index
		redirect_to course_path	
	end

	def new
		@task = Task.new
	end
	def show
		@task = Task.find(params[:id])
		@course = @task.course
	end

	def edit
		@course = Course.find(params[:course_id])
  		@task = Task.find(params[:id])
	end

	def update
		@course = Course.find(params[:course_id])
		@task = @course.tasks.find(params[:id])
		if @task.update(task_params)
		  redirect_to course_task_path(@course, @task)
		else
		  render 'edit'
		end
	end
	 

	def destroy 
		@task = Task.find(params[:id])
		@course = Course.find(params[:course_id])
		@task.destroy
		redirect_to @course
	end

	def create 
		course = Course.find(params[:course_id])
		@task = course.tasks.new(task_params)
		@task.user = current_user
		@task.date_of_published = DateTime.now
		if(@task.save)
			redirect_to course_path(course)
		else
			render 'new'
		end
	end
	private def task_params
		params.require(:task).permit(:title, :body, :deadline)
	end
end
