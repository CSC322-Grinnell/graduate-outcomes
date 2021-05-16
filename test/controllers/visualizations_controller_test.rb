require 'test_helper'

class VisualizationsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:test)
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: 'password' } }
    
    # note: student data in db required for new visualization to be valid                                     
    @student = Student.create(class_year: "2018", student_id: "12345", major1: "BIO", major2: "CSC", 
      gender: "M", fed_group: "white", intern: "TRUE", research: "FALSE", 
      service: "TRUE", career_related: "moderately", job_field: "consulting", FDS_cat: "employ", 
      gs_select: "TRUE", gs_level: "doctoral", gs_type: "science")
    @viz1 = Visualization.new(chart_title: "test chart", x_axis_title: "hor", 
      y_axis_title: "vert", chart_type: "Bar")
    @viz1.variables.build([{name: "class_year", role: "Group By"}])
    assert @viz1.save()
  end
  
  def teardown
    @viz1.destroy()
  end
  
  test "should get index" do
    get visualizations_path
    assert_response :success
    assert_template "index"
  end
  
  test "should get show" do
    get visualization_path(@viz1.id)
    assert_response :success
    assert_template "show"
  end

  test "should get new" do
    get new_visualization_path
    assert_response :success
    assert_template "new"
    assert_template :partial => "_form"
    assert_template :partial => "shared/_error_messages"
  end
  
  test "should post create" do 
    type = "Column"
    xt = "gender"
    yt = "count"
    title = "1varColChNoFltr"
    var_name = "gender"
    var_role = "Dependent"
    
    post visualizations_path, params: { 
      visualization: { 
      chart_type: type, x_axis_title: xt, y_axis_title: yt, chart_title: title, 
      variables_attributes: [var_name, var_role]
      } 
    }
    assert_response :success
    
    assert (Visualization.last.chart_title == title), "Could not find created visualization in database"
    assert_template "show"
    
    Visualization.last.destroy()
  end
  
  test "destroy should delete viz" do
    delete visualization_path(@viz1.id)
    assert_redirected_to controller: "visualizations", action: "index"
    assert (Visualization.find_by(chart_title: @viz1.chart_title) == nil)
  end
  
  test "should get edit" do
    get edit_visualization_path(@viz1.id)
    assert_response :success
    assert_template "edit"
    assert_template :partial => "_form_edit"
  end

  test "should patch update" do
    type = "Column"
    xt = "gender"
    yt = "count"
    title = "test update"
    var_name = "gender"
    var_role = "Dependent"
    
    patch visualization_path(@viz1.id), params: { 
      visualization: { 
      chart_type: type, x_axis_title: xt, y_axis_title: yt, 
      chart_title: title, 
      variables_attributes: [var_name, var_role]
      } 
    }
    
    updated_viz1 = Visualization.find(@viz1.id)
    assert (updated_viz1.chart_title == title), "Title from updated chart is unexpected"
    assert (updated_viz1.x_axis_title == xt), "x-axis title from updated chart is unexpected"
    assert (updated_viz1.y_axis_title == yt), "y-axis title from updated chart is unexpected"
    assert (updated_viz1.chart_type == type), "chart type from updated chart is unexpected"
    assert (updated_viz1.variables.first().name == var_name), 
      "variable name from updated chart is unexpected"
    assert (updated_viz1.variables.first().role == var_role), 
      "variable role from updated chart is unexpected"
    
    # revert the visualization db back to setup state
    Visualization.update(@viz1.id, @viz1.attributes)
  end
end