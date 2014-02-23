class Idea < ActiveRecord::Base
  acts_as_votable
  acts_as_commontable
  acts_as_taggable
end
