class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.all
    puts @restaurants.name
  end

  def show
    @restaurants = Restaurant.find(params[:id])
  end

  def new
    @restaurants = Restaurant.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
