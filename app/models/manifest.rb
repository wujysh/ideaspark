class Manifest < ActiveRecord::Base
  belongs_to :Idea
  belongs_to :User
end
