require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

    test "not logged in yet" do
        assert current_user.nil?
        assert_not logged_in?
    end

    test "should log in" do
        @user = users(:test)
        log_in(@user)
        assert session[:user_id] = @user.id
        assert logged_in?
        assert current_user = @user
    end

    test "should log out" do
        @user = users(:test)
        log_in(@user)
        log_out
        assert session[:user_id].nil?
        assert_not logged_in?
        assert current_user.nil?
    end

end