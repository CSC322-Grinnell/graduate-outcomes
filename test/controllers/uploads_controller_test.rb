require 'test_helper'

class UploadsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get uploads_path
    assert_response :success
  end

end
