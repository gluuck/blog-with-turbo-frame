# frozen_string_literal: true

class PostsController < ApplicationController
  
  def index
    posts
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.includes(:users, :comments).find(params[:id])
    @comment = @post.comments.build
  end

  def create
    subject = Posts::CreatePost.run post_params

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

  def create_member
    @post = Post.find(params[:id])
    
    subject  = Posts::CreateMember.run(post: @post, user: current_user)
    return resource_errors subject unless subject.valid?

    if subject.valid?
      redirect_to @post
    end
  end

  def remove_member
    @post = Post.find(params[:id])
    
    subject  = Posts::RemoveMember.run(post: @post, user: current_user)
    return resource_errors subject unless subject.valid?

    if subject.valid?
      redirect_to @post
    end
  end
  
  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def posts
    @posts = Post.all
  end
end
