require 'test_helper'

class VisualizationsControllerTest < ActionDispatch::IntegrationTest
  
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
