# frozen_string_literal: true

module Posts
  class RemoveMember < ActiveInteraction::Base
    object :post, :user

    def execute
      post.users.delete(user)
      user.change_role(user, 0)
    end
  end
end
