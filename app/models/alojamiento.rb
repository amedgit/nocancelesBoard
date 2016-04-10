class Alojamiento < ActiveRecord::Base
  acts_as_votable
  belongs_to :user
  has_one :pic , as: :imageable , dependent: :destroy
  has_many :comments , as: :commentable , dependent: :destroy
  accepts_nested_attributes_for :pic , allow_destroy: true
  validates_associated :pic
  
  scope :like, ->(args) { where("LOWER(city) like LOWER('%#{args}%') OR LOWER(cat) like LOWER('%#{args}%') OR LOWER(title) like LOWER('%#{args}%') ")}
  scope :cate, ->(args) { where(" LOWER(cat) like LOWER('%#{args}%') ")}
  scope :ciudad, ->(args) { where(" LOWER(city) like LOWER('%#{args}%') ")}

end
