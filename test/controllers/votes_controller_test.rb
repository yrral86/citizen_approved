require 'test_helper'

class VotesControllerTest < ActionController::TestCase
  test "should get upcoming" do
    get :upcoming
    assert_response :success
  end

  test "should get submit" do
    get :submit
    assert_response :success
  end

  test "should get compare" do
    get :compare
    assert_response :success
  end

end
