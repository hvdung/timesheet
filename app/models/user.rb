class User < ApplicationRecord
  enum gender: Settings.gender.to_hash
end
