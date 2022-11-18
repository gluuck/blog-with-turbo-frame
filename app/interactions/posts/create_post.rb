module Posts
  class CreatePost < ActiveInteraction::Base
    string :title, :body

    def execute
      post = Post.new inputs

      errors.merge! post.errors unless post.save
      post
    end
  end
end
