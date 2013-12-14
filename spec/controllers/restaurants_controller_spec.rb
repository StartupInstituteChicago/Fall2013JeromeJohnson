require 'spec_helper'

describe RestaurantsController do

  # I also added a check for the index action that it redirects the user to login
  # when not already signed in
  context "when the user is not logged in" do
    it "redirects the index route to the login page" do
      get :index
      expect(response).to redirect_to new_owner_session_path
    end
  end

  #these were failing b/c you need to sign_in the user
  context "when the user is logged in" do
    let(:owner) { FactoryGirl.create(:owner) }
    before(:each) do
      sign_in(owner)
    end

    describe 'GET "index"' do
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

    describe 'POST "create"' do
      let (:params) do
        {
          restaurant: {
            name: "Test Restaurant",
            description: "Fancy family cuisine",
            address: "820 W. Jackson St. Chicago, IL 60607",
            phone_number: "312.411.3000"
          }
        }
      end

      # a couple of ways to do this...I'm going to use the same parameters a few times, so I'll create a variable
      # using let() above...  you could also write it inline like:
      # post :create, restaurant: { name: "Test Restaurant", description: ""... }
      it "creates a new restaurant" do
        post :create, params
        expect(Restaurant.count).to eq 1
      end

      # a more interesting use of RSpec
      it "creates a new restaurant" do
        expect {
          post :create, params
        }.to change{Restaurant.count}.by(1)
      end

      # another way to test.  I often do this to make tests "fast" b/c they never hit the database, but it opens you up
      # to possible bugs.  I've started moving away from this b/c it's testing the "how" too much and not the outcome
      it "creates a new restaurant" do
        expected_params = params[:restaurant].merge({ owner_id: owner.id }).stringify_keys
        Restaurant.should_receive(:create).with(expected_params)
        post :create, params
      end

    end
  end
end
