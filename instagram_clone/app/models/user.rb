class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :photos
  has_many :comments

  def has_commented_on?(photo)
  commented_on_photos.include? photo
  end

  has_many :commented_on_photos, through: :comments, source: :photo


end
