class Restaurant < ActiveRecord::Base
  validates :name, :description, :address, :phone_number, presence:true
  validates :name, :address, length: { minimum: 4 }
  validates :phone_number, length: { minimum: 10 }
  
  mount_uploader :avatar, AvatarUploader

  belongs_to :owner
end
