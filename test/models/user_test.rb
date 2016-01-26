require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = " "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jb alice+bob@baz.cn]
    valid_addresses.each do |address|
      @user.email = address
      assert @user.valid?, "#{address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |address|
      @user.email = address
      assert_not @user.valid?, "#{address.inspect} should not be valid"
    end
  end

  test "user with duplicate email address should be invalid" do
    duplicate_user = @user.dup
    @user.save
    duplicate_user.email = @user.email.upcase
    assert_not duplicate_user.valid?
  end

  test "password should not be blank" do
    @user.password = @user.password_confirmation = " "
    assert_not @user.valid?
  end

  test "password should have at least 6 chars" do
    @user.password = @user.password_confirmation = "foooo"
    assert_not @user.valid?
  end

end
