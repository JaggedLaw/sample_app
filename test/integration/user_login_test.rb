require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
  end


  test "successful login renders user page" do
    visit login_path
    fill_in 'Email', :with => 'user@example.com'
    fill_in 'Password', :with => 'foobar'
    click_button('Log in')
    assert current_path, user_path(@user)
    assert_not page.has_content?('Log in')
    assert page.has_content?('Log out')
    assert page.has_content?('Profile')
  end

  test "unsuccessful login renders same page and an error message" do
    visit login_path
    fill_in 'Email', :with => 'wrong_user@example.com'
    fill_in 'Password', :with => 'foobar'
    click_button('Log in')
    assert current_path, login_path
    within("#flash_message") do
      assert page.has_content?('Invalid email/password combination')
    end
    visit root_path
    within("#flash_message") do
      assert_not page.has_content?('Invalid email/password combination')
    end
  end

end
