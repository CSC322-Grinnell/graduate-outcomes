require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:test)
  end

  test "user should have email" do
    @user.email = ""
    assert_not @user.valid?
  end

  test "user email is valid" do
    @user.email = "test@gmail.com"
    assert_not @user.valid?
  end

  test "user should have password" do
    @user.password = ""
    assert_not @user.valid?
  end

  test "password should be long enough" do
    @user.password = "aaaaa"
    assert_not @user.valid?
  end

end
