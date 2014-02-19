class User < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 64 }
  validates :email, presence: true
end
