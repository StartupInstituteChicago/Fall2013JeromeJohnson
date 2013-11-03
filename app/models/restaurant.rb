class Restaurant < ActiveRecord::Base
  validates :name, :description, :address, :phone_number, presence:true
  validates :name, length: { minimum: 4 }
end
