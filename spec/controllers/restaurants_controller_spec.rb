require 'spec_helper'

describe RestaurantsController do 
  it "successfully gets the index page" do
    get(:index)
    expect(response).to be_success
   # expect(response.status).to eq(200)
  end

  it "should render index template" do
    get(:index)
    response.should render_template("index")
  end

  it "loads each restaurant into @restaurants" do
    get :index
    expect(assigns[:restaurants]).to eq Restaurant.all
  end
end