# frozen_string_literal: true

module Posts
  class CreateMember < ActiveInteraction::Base
    object :post, :user

    def execute
      post.users << user
      user.update_role(user, 1)
    end
  end
end