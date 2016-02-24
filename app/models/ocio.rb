class Ocio < ActiveRecord::Base
  acts_as_votable
  belongs_to :user
  has_many :pics , as: :imageable , dependent: :destroy
  has_many :comments , as: :commentable , dependent: :destroy
  accepts_nested_attributes_for :pics , allow_destroy: true
end
