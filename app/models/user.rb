class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [:guest, :member, :admin]

  def update_role(user, role)
    transaction do
      user.update!(role: role)
    end
  end
end
