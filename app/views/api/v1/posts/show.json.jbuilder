# frozen_string_literal: true

json.post do
  json.body_post @post, :id, :title, :body
  json.comments @post.comments do |comment|
    json.comment_body comment, :id, :body, :created_at
    json.author_comment comment.user, :id, :email
  end
  json.post_author @post.author, :id, :email
end
