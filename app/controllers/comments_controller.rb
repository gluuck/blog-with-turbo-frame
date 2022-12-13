# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    # debugger
    if @comment.save
      redirect_to post_path(@post)
    else
      @comment.errors.full_messages.join(' ')
    end
  end

  def edit; end

  def destroy; end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
