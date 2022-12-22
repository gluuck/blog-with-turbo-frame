# frozen_string_literal: true

json.comment @post.comments do |comment|
  json.comment_body comment, :id, :body, :created_at
  json.author comment.user
end
json.comments_users_emails @post.comments.map { |comment| { "email_#{comment.user.id}": comment.user.email } }
