class PostsController < ApplicationController
  def index
    posts   
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path, notice: 'Post created'
    else      
      render turbo_stream: turbo_stream.update('alert', partial: 'posts/error', locals:{resource: @post})
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.delete
    render turbo_stream: [turbo_stream.update('posts', template: 'posts/index', locals:{:@posts => posts}),
      turbo_stream.update('notice','Post deleted')]
    #redirect_to root_path, notice: 'Post deleted'
  end

  private

  def post_params
    params.fetch(:post, {}).permit(:title, :body)
  end

  def posts
    @posts = Post.all 
  end
end
