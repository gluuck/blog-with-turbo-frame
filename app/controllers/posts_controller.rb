# frozen_string_literal: true

class PostsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :post_not_found

  def index
    posts
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def show
    @post = Post.find(params[:id])
    @comment = @post.comments.build
  end

  def create
    subject = Posts::CreatePost.run post_params.merge(author: current_user)

    if subject.valid?
      render turbo_stream: [turbo_stream.update('posts', template: 'posts/index', locals: { :@posts => posts }),
                            turbo_stream.update('notice', 'Post created')]
    else
      render turbo_stream: turbo_stream.update('alert', partial: 'posts/error', locals: { resource: subject })
    end
  end

  def destroy
    post = Post.find(params[:id])
    subject = Posts::DestroyPost.run(post: post)
    render turbo_stream: [turbo_stream.update('posts', template: 'posts/index', locals: { :@posts => posts }),
                          turbo_stream.update('notice', 'Post deleted')]
  end

  def update
    post = Post.find(params[:id])
    inputs = { post: post}.reverse_merge(params[:post])
    subject = Posts::UpdatePost.run inputs

    if subject.valid?
      render turbo_stream: [turbo_stream.update('posts', template: 'posts/index', locals: { :@posts => posts }),
                            turbo_stream.update('notice', 'Post updated')]
    else
      render turbo_stream: turbo_stream.update('alert', partial: 'posts/error', locals: { resource: subject })
    end
  end

  def create_member
    @post = Post.find(params[:id])

    subject = Posts::CreateMember.run(post: @post, user: current_user)
    return resource_errors subject unless subject.valid?

    redirect_to @post if subject.valid?
  end

  def remove_member
    @post = Post.find(params[:id])

    subject = Posts::RemoveMember.run(post: @post, user: current_user)
    return resource_errors subject unless subject.valid?

    redirect_to @post if subject.valid?
  end

  private

  def post_not_found
    render plain: 'Post not found', status: 404
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def posts
    @posts = Post.includes(:author, :comments).all
  end
end
