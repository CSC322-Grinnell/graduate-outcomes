require 'test_helper'

class NavbarTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:test)
  end

  test "root path when not logged in" do
    post login_path, params: { session: { email: "", password: "" } }
    get root_path
    assert_redirected_to login_path
    follow_redirect!
    assert_template 'sessions/new'
    assert_select "a[href=?]", visualizations_path, count: 0
    assert_select "a[href=?]", new_visualization_path, count: 0
    assert_select "a[href=?]", signup_path, count: 2
    assert_select "a[href=?]", login_path, count: 2
    assert_select "a[href=?]", uploads_path, count: 0
    assert_select "a[href=?]", edit_user_path(@user), count: 0
    assert_select "a[href=?]", valid_emails_path, count: 0
    assert_select "a[href=?]", logout_path, count: 0
  end

  test "root path when logged in already" do
    post login_path, params: { session: { email: @user.email,
                                          password: 'password' } }
    get root_path
    assert_template 'visualizations/index'
    assert_select "a[href=?]", logout_path, count: 2
    assert_select "a[href=?]", visualizations_path, count: 2
    assert_select "a[href=?]", new_visualization_path
    assert_select "a[href=?]", signup_path, count: 0
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", uploads_path, count: 2
    assert_select "a[href=?]", edit_user_path(@user), count: 2
    assert_select "a[href=?]", valid_emails_path, count: 2
  end
end
