class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable
  enum gender: Settings.gender.to_h
  has_many :user_groups, dependent: :nullify
  has_many :groups, through: :user_groups, dependent: :nullify
end
