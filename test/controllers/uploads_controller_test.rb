require 'test_helper'

class UploadsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:test)
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: 'password' } }
  end
  
  test "should get index" do
    get uploads_path
    assert_response :success
  end

end
