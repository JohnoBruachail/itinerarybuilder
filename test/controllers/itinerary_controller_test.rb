require 'test_helper'

class ItineraryControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get itinerary_new_url
    assert_response :success
  end

  test "should get current" do
    get itinerary_current_url
    assert_response :success
  end

end
