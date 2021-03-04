require 'test_helper'

class ValidEmailsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:test)
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: 'password' } }
  end
  
  test "should get new" do
    get valid_emails_path
    assert_response :success
  end

end
