# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @comment = @commentable.comments.build(comment_params)

    @comment.user = current_user
    if @comment.save
      redirect_to @commentable
    else
      @comment.errors.full_messages.join(' ')
    end
  end

  def edit; end

  def destroy
    #post = Post.find(params[:post_id])
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to @commentable
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
