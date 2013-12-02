class ReservationsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @reservation = @restaurant.reservations.new
  end

  def show
  	@reservation = Reservation.find(params[:id])
  end

  def create
  	@restaurant = Restaurant.find(params[:restaurant_id])
  	@reservation = @restaurant.reservations.new(reservation_params)

  	if @reservation.save
      ReservationMailer.reservation_confirmation(@user).deliver
  		redirect_to restaurant_reservation_path(@reservation.restaurant_id,
  		 @reservation.id)
  	else
  		render 'new'
  	end
  end

  def index
  	@restaurant = Restaurant.find(params[:restaurant_id])
  	if owner_signed_in? && current_owner == @restaurant.owner
  		@reservations = @restaurant.reservations
  	else
  		flash[:notice] = "You are not Authorized for this action!"
  		redirect_to restaurants_path
  	end
  end

  def edit
  	@reservation = Reservation.find(params[:id])
  end

  def destroy
  	@restaurant = Restaurant.find(params[:restaurant_id])
  	@reservation = @restaurant.reservations.find(params[:id])

  	if current_owner == @reservation.restaurant.owner
  		@reservation.destroy
  		redirect_to restaurant_reservations_path(@reservation.restaurant_id)
  	else
  		flash[:notice] = "You are not authorized to delete this reservation!"
  		redirect_to restaurants_path
  	end
  end

  private
  def reservation_params
  	params.require(:reservation).permit(:email, :requested_date_time, :message)
  end

end
