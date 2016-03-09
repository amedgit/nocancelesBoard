class Transport < ActiveRecord::Base
  acts_as_votable
  belongs_to :user
  has_one :pic , as: :imageable , dependent: :destroy
  has_many :comments , as: :commentable , dependent: :destroy
  accepts_nested_attributes_for :pic , allow_destroy: true
  validates_associated :pic
  validates :title , presence: true
  scope :like, ->(args) { where("to_city like '%#{args}%' OR from_city like '%#{args}%' OR cat like '%#{args}%' OR title like '%#{args}%' ")}

end
