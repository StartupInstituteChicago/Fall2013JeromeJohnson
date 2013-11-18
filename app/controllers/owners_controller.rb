class OwnersController < ApplicationController

	def edit
		@owner = Owner.find(params[:id])
	end
end