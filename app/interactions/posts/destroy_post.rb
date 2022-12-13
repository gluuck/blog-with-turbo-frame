# frozen_string_literal: true

module Posts
  class DestroyPost < ActiveInteraction::Base
    object :post

    def execute
      post.destroy
    end
  end
end
