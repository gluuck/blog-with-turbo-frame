class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :comments,  dependent: :destroy
  has_many :results
  has_many :posts, through: :results

  enum role: [:guest, :member, :admin]

  def update_role(user, role)
    transaction do
      user.update!(role: role)
    end
  end

  def change_role(user, role)
    transaction do
      user.update!(role: role)
    end
  end
end
