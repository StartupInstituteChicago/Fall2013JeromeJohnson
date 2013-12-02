class OwnersController < ApplicationController

	def dashboard
    @restaurants = Restaurant.where(owner: current_owner)
  end
end