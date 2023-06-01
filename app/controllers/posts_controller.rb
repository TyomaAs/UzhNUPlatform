class PostsController < ApplicationController
	before_action :redirect_if_not_authenticated, only: [:create, :new, :index, :show, :destroy, :edit]
	def index
		redirect_to course_path
	end

	def new
		@post = Post.new
	end
	
	def show
		@post = Post.find(params[:id])
		@course = @post.course
		@comment = Comment.all
	end

	def edit
		@course = Course.find(params[:course_id])
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])
		if(@post.update(post_params))
			course_id = @post.course_id
			redirect_to course_path(course_id)
		else
			render 'edit'
		end
	end

	def destroy 
		@post = Post.find(params[:id])
		course_id = @post.course_id
		@post.destroy
		redirect_to course_path(course_id)
	end
	 
	def create 
		course = Course.find(params[:course_id])
		@post = course.posts.new(post_params)
		@post.user = current_user
		if(@post.save)
			redirect_to course_path(course)
		else
			render 'new'
		end
	end
	
	private def post_params
		params.require(:post).permit(:title, :body, :date)
	end
end
