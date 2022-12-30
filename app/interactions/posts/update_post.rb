
module Posts
  class UpdatePost < ActiveInteraction::Base
    object :post
    string :title, :body, default: nil

    def execute

      post.title = title
      post.body = body

      errors.merge! post.errors unless post.save
      post
    end
  end
end
