# frozen_string_literal: true

json.posts @posts do |post|
  json.post_body post, :id, :title, :body, :created_at
end
