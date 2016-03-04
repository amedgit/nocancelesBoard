class User < ActiveRecord::Base
  has_many :ocios , dependent: :destroy
  has_many :transports , dependent: :destroy
  has_many :alojamientos , dependent: :destroy
  has_many :comments , dependent: :destroy
  has_one :perfil , dependent: :destroy
 validates :terms_and_conditions, acceptance: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

end
