# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :commentable, counter_cache: true, polymorphic: true
  belongs_to :user
  validates :body, presence: true
end
