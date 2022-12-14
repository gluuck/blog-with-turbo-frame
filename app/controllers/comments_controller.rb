# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @comment = @commentable.comments.build(comment_params)
    if @comment.save
      redirect_to post_path(@commentable)
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
