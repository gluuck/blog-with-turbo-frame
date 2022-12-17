# frozen_string_literal: true

class Post < ApplicationRecord
  has_many :comments, dependent: :destroy, as: :commentable
  belongs_to :author, class_name: 'User', optional: true
  has_many :results
  has_many :users, through: :results
  validates :title, :body, presence: true
end
