class RestaurantsController < ApplicationController
  before_filter :authenticate_owner!

  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @address = @restaurant.address
    @gmaps_key = ENV['G_MAP_API_KEY']
    @owner = current_owner
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    # I notice that you are premitting some of the fields on create, but not the avatar/avatar_url
    # Is that intended?
    #
    # @restaurant = Restaurant.new(params[:restaurant].permit(:name, :description,
    #   :address, :phone_number))
    # @restaurant.owner = current_owner

    # this line is a little sloppy still, so i might pull it into a separate get restaurant params method
    # especially if it is reused below.  I see your post_params method which is exactly the right idea.  Just didn't
    # get used above.
    merged_params = params.require(:restaurant)
                      .permit(:name, :description, :address, :phone_number)
                      .merge({ owner_id: current_owner.id })

    if @restaurant = Restaurant.create(merged_params)
      redirect_to @restaurant
    else
      render 'new'
    end
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])

    # Doesn't look like you're
    # checking if the restaurant's current owner is the current owner...

    #I'll add a check here in line... you could create a private method and use it as a filter instead...
    if @restaurant.owner != current_owner
      flash[:error] = "Restaurant NOT updated - You must be the restaurant owner to make edits!"
      return redirect_to @restaurant
    end

    # Here's the other place to reuse that params method.
    if @restaurant.update(params[:restaurant].permit(:name, :description,
     :address, :phone_number, :avatar, :avatar_url))
      redirect_to @restaurant
    else
      render 'edit'
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy

    redirect_to restaurants_path
  end


  private
    def post_params
      params.require(:restaurant).permit(:name, :description, :address,
       :phone_number, :avatar, :avatar_url)
    end
end
