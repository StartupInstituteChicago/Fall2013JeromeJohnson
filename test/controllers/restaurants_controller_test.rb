require 'test_helper'

class RestaurantsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

    test "Should get index page" do
      get :index
      assert_response :success
    end

    test "Should get new page" do
      get :new
    end

end
