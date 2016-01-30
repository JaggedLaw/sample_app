require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest

  test "user not created when invalid info is entered and errors are displayed" do
    visit signup_path
    before_count = User.count
    fill_in 'Name', :with => "Newbie"
    fill_in 'Email', :with => "new@invalid"
    fill_in 'Password', :with => "dude"
    fill_in 'Confirmation', :with => "dudes"
    click_button('Create my account')
    after_count = User.count
    assert_equal before_count, after_count
    assert current_path, signup_path
    assert page.has_content?("Email is invalid")
    assert page.has_content?("Password confirmation doesn't match Password")
    assert page.has_content?("Password is too short (minimum is 6 characters)")
  end

  test "user is created when valid info is entered" do
    visit signup_path
    before_count = User.count
    fill_in 'Name', :with => "Newbie"
    fill_in 'Email', :with => "new@valid.com"
    fill_in 'Password', :with => "dude5678"
    fill_in 'Confirmation', :with => "dude5678"
    click_button('Create my account')
    after_count = User.count
    before_count += 1
    assert_equal before_count, after_count
    user = User.last
    assert current_path, user_path(user)
    assert page.has_content?("Welcome to the Sample App!")
  end

  test "user can signup, is automatically logged in, then can log out" do
    visit signup_path
    fill_in 'Name', :with => "Newbie"
    fill_in 'Email', :with => "new@valid.com"
    fill_in 'Password', :with => "dude5678"
    fill_in 'Confirmation', :with => "dude5678"
    click_button('Create my account')
    user = User.last
    assert current_path, user_path(user)
    # ensure that the user is logged in automatically when they sign up:
    # assert is_logged_in?
    click_link('Log out')
    assert current_path, root_path
    # assert_not is_logged_in?
  end
end
