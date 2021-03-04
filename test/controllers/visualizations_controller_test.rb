require 'test_helper'

class VisualizationsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:test)
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: 'password' } }
  end
  
  test "should get index" do
    get visualizations_path
    assert_response :success
  end

  # TODO: we can't test this without passing an id. Ask Barbara.
  # test "should get show" do
  #   get visualization_path
  #   assert_response :success
  # end

  test "should get new" do
    get new_visualization_path
    assert_response :success
  end

end
