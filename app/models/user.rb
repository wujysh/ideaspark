class User < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 64 }
  validates :email, presence: true, length: { minumum: 5, maximum: 320 }
end
