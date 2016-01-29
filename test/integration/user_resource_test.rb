require 'test_helper'

class UserResourceTest < ActionDispatch::IntegrationTest

  test "guest can sign up" do
    skip
    visit signup_path
    fill_in 'Name', :with => "Newbie"
    fill_in 'Email', :with => "Email"
    fill_in 'Password', :with => "password"
    fill_in 'Confirmation', :with => "password"
  end
end
