class Transport < ActiveRecord::Base
  acts_as_votable
  belongs_to :user
  has_one :pic , as: :imageable , dependent: :destroy
  has_many :comments , as: :commentable , dependent: :destroy
  accepts_nested_attributes_for :pic , allow_destroy: true
  validates_associated :pic
  validates :title , presence: true
  scope :like, ->(args) { where("LOWER(to_city) like '%#{args}%' OR LOWER(from_city) like '%#{args}%' OR LOWER(cat) like '%#{args}%' OR LOWER(title) like '%#{args}%' ")}

end
