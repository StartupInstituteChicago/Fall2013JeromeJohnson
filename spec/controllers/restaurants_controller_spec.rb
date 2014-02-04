
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

    describe 'POST "update"' do
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

      context "when restaurant is not owned by the current owner" do

        # here we need to createa an actual restaurant b/c update
        # will need to look it up by id
        let(:restaurant) { FactoryGirl.create(:restaurant, owner: FactoryGirl.create(:owner, name: "Not me")) }



        it "redirects with a flash message" do
          post :update, params.merge(id: restaurant.id)
          expect(flash[:error]).to_not be_empty
        end

        it "should not update the restaurant" do
          # you could do a more datacentric approach to this validation like refresh the restaurant
          # and ensure it's value didn't change, but this is good enough for me.
          restaurant.should_not_receive(:update)
          post :update, params.merge(id: restaurant.id)
        end

        it "redirects back to the restaurant" do
          post :update, params.merge(id: restaurant.id)
          expect(request).to redirect_to(restaurant_path(restaurant))
        end

      end

      context "when restaurnt is owned by the current owner" do
        # here we need to create an actual restaurant b/c update
        # will need to look it up by id.  This owner is defined in let(:owner) up at the top
        let(:restaurant) { FactoryGirl.create(:restaurant, owner: owner) }

        it "updates the restaurant" do
          post :update, params.merge(id: restaurant.id)
          expect(restaurant.reload.name).to eq params[:restaurant][:name]   #notice that I had to reload our restaurant
        end

        it "redirects to the restaurant" do
          post :update, params.merge(id: restaurant.id)
          expect(response).to redirect_to(restaurant_path(restaurant))
        end

        #note how this renders the template instead of redirecting.  This test is really only meaningful when the
        # one right above passes too (otherwise, both could just render the edit template and we wouldn't know the
        # rediret one was failing!)
        it "if save fails it remains on edit" do
          Restaurant.any_instance.stub(:update).and_return(false)  #this is a way to see what happens when the update fails
          post :update, params.merge(id: restaurant.id)
          expect(response).to render_template(:edit)
        end

      end
    end
  end
end
