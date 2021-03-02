require 'test_helper'

class ValidEmailsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get valid_emails_new_url
    assert_response :success
  end

end
