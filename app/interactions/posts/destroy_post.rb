# frozen_string_literal: true

module Posts
  class DestroyPost < ActiveInteraction::Base
    object :post

    def execute
      post.users.delete_all
      post.destroy
    end
  end
end
