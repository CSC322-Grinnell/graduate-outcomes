require 'test_helper'

class NavbarTest < ActionDispatch::IntegrationTest
	test "Valid links appear when nav buttons are clicked" do
		get root_path
        assert_template 'visualization/index'
        assert_select "a[href=?]", visualization_index_path
        assert_select "a[href=?]", visualization_new_path
        assert_select "a[href=?]", upload_index_pathh
	end
	
end
