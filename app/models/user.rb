# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :comments
  has_many :results
  has_many :posts, through: :results

  enum role: %i[guest member admin]

  def update_role(user, role)
    transaction do
      user.update!(role:)
    end
  end
end
