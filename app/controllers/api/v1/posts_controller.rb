module Api
  module V1
    class PostsController < Api::BaseController

      def index
        render json: posts
      end

      def new
        @post = Post.new
      end

      def show
        @post = Post.includes(:author, :comments).find(params[:id])
        # render json: :show, status: :ok, location: @post
        # render_success @post.as_json
      end

      def create
        subject = Posts::CreatePost.run post_params
        return resource_errors subject unless subject.valid?

        if subject.valid?
          render json: subject
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
  end
end
