class Pic < ActiveRecord::Base
  belongs_to :imageable , polymorphic: true
  has_attached_file :image , styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image , content_type: /\Aimage\/.*\Z/
  validates_presence_of :image
end
