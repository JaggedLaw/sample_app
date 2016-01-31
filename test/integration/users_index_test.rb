require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  test "should redirect index when not logged in" do
    skip
    visit users_path
    assert_equal login_url, current_path
  end

end
