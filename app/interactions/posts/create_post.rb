# frozen_string_literal: true

module Posts
  class CreatePost < ActiveInteraction::Base
    object :author, class: User
    string :title, :body

    def execute  
      post = Post.new inputs

      errors.merge! post.errors unless post.save
      post
    end
  end
end
