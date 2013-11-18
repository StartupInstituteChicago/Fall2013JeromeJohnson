class Reservation < ActiveRecord::Base
  validates :email, :requested_date_time, presence:true

  belongs_to :restaurant
end
