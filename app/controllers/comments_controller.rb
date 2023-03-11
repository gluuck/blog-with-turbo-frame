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
    #debugger
    comment = @commentable.comments.find(params[:id])
    if comment.destroy
      render turbo_stream: [turbo_stream.update('post', partial: 'posts/post_comments', locals: { post: @commentable }),
                            turbo_stream.update('notice', 'Comment deleted')]
    end

  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
