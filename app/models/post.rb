# frozen_string_literal: true

class Post < ApplicationRecord
  has_many :comments, as: :commentable, dependent: :delete_all
  belongs_to :author, class_name: 'User', optional: true
  has_many :results
  has_many :users, through: :results
  validates :title, :body, presence: true

  after_create :create_member

  def author?(user)
    self.author == user
  end

  def create_member
    subject = Posts::CreateMember.run(post: self, user: author)
    return resource_errors subject unless subject.valid?
  end
end
