require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should get edit" do
    @user = users(:test)
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: 'password' } }
    get edit_user_path(@user)
    assert_response :success
  end

end
