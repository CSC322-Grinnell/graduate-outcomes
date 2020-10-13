require 'test_helper'

class NavbarTest < ActionDispatch::IntegrationTest
	test "Valid links appear when nav buttons are clicked" do
		get root_path
<<<<<<< HEAD
        assert_template 'visualization/index'
        assert_select "a[href=?]", visualization_index_path
        assert_select "a[href=?]", visualization_new_path
        assert_select "a[href=?]", upload_index_pathh
=======
    assert_template 'visualizations/index'
    assert_select "a[href=?]", visualizations_path
    assert_select "a[href=?]", new_visualization_path
    assert_select "a[href=?]", uploads_path
>>>>>>> master
	end
	
end
