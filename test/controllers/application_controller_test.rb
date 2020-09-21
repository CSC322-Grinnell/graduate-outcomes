require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test "should get visualize route" do
    get visualize_path
    assert_response :success
  end
  
  test "should get root" do
    get root_url
    assert_response :success
  end
  
  test "should get create route" do
    get create_path
    assert_response :success
  end
  
  test "should get upload route" do
    get upload_path
    assert_response :success
  end

end
