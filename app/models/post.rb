# frozen_string_literal: true

class Post < ApplicationRecord
  has_many :comments, dependent: :destroy, as: :commentable
  has_many :users, dependent: :destroy
  validates :title, :body, presence: true
end
