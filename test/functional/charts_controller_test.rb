require 'test_helper'

class ChartsControllerTest < ActionController::TestCase
  test "should get screen2MB" do
    get :screen2MB
    assert_response :success
  end

end
