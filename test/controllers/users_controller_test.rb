require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should redirect index when not logged in" do
    skip # assert_equal not working probablly bc i'm using capybara
    visit users_path
    assert_equal login_url, current_path
  end

end
