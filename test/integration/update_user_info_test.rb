require 'test_helper'

class UpdateUserInfoTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(name: "Original", email:"Original@email.com", password:"password", password_confirmation:"password" )
    @other_user = User.create(name:"hacker", email:"hacker@email.com", password:"ihack72", password_confirmation:"ihack72")
  end

  test "edits with invalid info will not update the database" do
    log_in_as(@user)
    visit edit_user_path(@user)
    fill_in 'Name', :with => "Edited User"
    fill_in 'Email', :with => "edited@email"
    fill_in 'Password', :with => "edit"
    fill_in 'Password confirmation', :with => "edit"
    click_button('Save changes')
    assert_equal "Original", @user.name
    assert_equal "original@email.com", @user.email
    assert_equal user_path(@user), current_path
    assert page.has_content?('Password is too short')
  end

  test "user can update their information in the database" do
    log_in_as(@user)
    visit edit_user_path(@user)
    fill_in 'Name', :with => "Edited User"
    fill_in 'Email', :with => "edited@email.com"
    fill_in 'Password', :with => "edited"
    fill_in 'Password confirmation', :with => "edited"
    click_button('Save changes')
    @user.reload
    assert_equal "Edited User", @user.name
    assert_equal "edited@email.com", @user.email
    assert_equal user_path(@user), current_path
    assert page.has_content?('Profile updated')
  end

  test "user can update their info without updating their password" do
    log_in_as(@user)
    visit edit_user_path(@user)
    fill_in 'Name', :with => "Edited User"
    fill_in 'Email', :with => "edited@email.com"
    click_button('Save changes')
    @user.reload
    assert_equal "Edited User", @user.name
    assert_equal "edited@email.com", @user.email
    assert_equal user_path(@user), current_path
    assert page.has_content?('Profile updated')
  end

  test "one logged in user cannot access another users update page" do
    log_in_as(@other_user)
    visit edit_user_path(@user)
    assert_equal root_path, current_path

  end

end
