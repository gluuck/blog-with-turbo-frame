# frozen_string_literal: true

class Post < ApplicationRecord
  has_many :comments, as: :commentable, dependent: :delete_all
  belongs_to :author, class_name: 'User', optional: true
  has_many :results
  has_many :users, through: :results
  validates :title, :body, presence: true
end
