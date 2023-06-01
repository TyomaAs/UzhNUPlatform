class CommentsController < ApplicationController
	before_action :redirect_if_not_authenticated, only: [:create, :new, :index, :show, :destroy, :edit]
	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.new(comments_params)
		@comment.username = current_user.name
		if @comment.save
		  redirect_to course_post_path(@post.course, @post)
		else
		  render 'new'
		end
	end
	def new 
		@comment = Comment.new
	end
	private def comments_params
		params.require(:comment).permit(:username, :body)
	end
end
