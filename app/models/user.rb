class User < ApplicationRecord
  enum gender: { male: 1, female: 2, other: 3 }
  validates :first_name, :last_name, :gender, presence: true
  validates :email, uniqueness: true, presence: true
end
