require 'test_helper'

class NavbarTest < ActionDispatch::IntegrationTest
	test "Valid links appear when nav buttons are clicked" do
		get root_path
    assert_template 'sessions/new'
    assert_select "a[href=?]", visualizations_path
    assert_select "a[href=?]", new_visualization_path
    assert_select "a[href=?]", uploads_path
	end
	
end
