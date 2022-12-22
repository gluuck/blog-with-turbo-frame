# frozen_string_literal: true

module Api
  module V1
    class PostsController < Api::BaseController
      rescue_from ActiveRecord::RecordNotFound, with: :post_not_found

      def index
        posts
      end

      def new
        @post = Post.new
      end

      def show
        @post ||= Post.includes(:author, :comments).find(params[:id])
      end

      def create
        subject = Posts::CreatePost.run post_params
        return resource_errors subject unless subject.valid?

        render json: subject if subject.valid?
      end

      def destroy
        post = Post.find(params[:id])
        subject = Posts::DestroyPost.run(post: post)
      end

      def create_member
        @post = Post.find(params[:id])
        subject = Posts::CreateMember.run(post: @post, user: current_user)
        return resource_errors subject unless subject.valid?

        subject
      end

      def remove_member
        @post = Post.find(params[:id])

        subject = Posts::RemoveMember.run(post: @post, user: current_user)
        return resource_errors subject unless subject.valid?

        subject
      end

      private

      def post_not_found
        render_errors(errors: 'Post not found', status: 404)
      end

      def post_params
        params.require(:post).permit(:title, :body)
      end

      def posts
        @posts = Post.order(created_at: :desc)
      end
    end
  end
end
