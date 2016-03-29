class CommentsController < ApplicationController
	before_action :find_comment, only: [:create, :edit, :update, :destroy]
	def create
		@comment = @post.comments.create(params[:comment].permit(:comment))
		@comment.user_id = current_user.id if current_user
		@comment.save

		if @comment.save
			redirect_to post_path(@post)
		else
			render 'new'
		end

	end

	def destroy
		@comment = @post.comments.find(params[:id])
		@comment.destroy
		redirect_to post_path(@post)
	end

	def edit
		@comment = @post.comments.find(params[:id])
	end

	def update
		@comment = @post.comments.find(params[:id])

		if @comment.update(params[:comment].permit(:comment))
			redirect_to post_path(@post)
		else
			render 'edit'
		end
	end

	private

	def find_comment
		@post = Post.find(params[:post_id])
	end
end
