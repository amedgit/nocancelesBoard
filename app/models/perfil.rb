class Perfil < ActiveRecord::Base
  acts_as_votable
  has_many :comments , as: :commentable , dependent: :destroy
  belongs_to :user
  has_one :pic , as: :imageable , dependent: :destroy
  accepts_nested_attributes_for :pic , allow_destroy: true
  validates_associated :pic
end
