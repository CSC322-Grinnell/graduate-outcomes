require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test "should get visualize route" do
    get visualize_path
    assert_response :success
    assert_template 'features/visualize'
  end
  
  test "should get root" do
    get root_url
    assert_response :success
    assert_template 'features/visualize'
  end
  
  test "should get create route" do
    get create_path
    assert_response :success
    assert_template 'features/create'
  end
  
  test "should get upload route" do
    get upload_path
    assert_response :success
    assert_template 'features/upload'
  end

end
