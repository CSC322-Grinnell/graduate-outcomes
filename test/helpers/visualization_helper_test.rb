require 'test_helper'
#require 'visualizations_helper.rb'

class VisualizationsHelperTest < ActionView::TestCase
  # vis = Visualization.new(chart_type: "bar", x_axis_title: "x-axis", y_axis_title: "y-axis", chart_title: "chart_title", created_at: "5:30", updated_at: "5:30")
  # student = Student.create(class_year: "2018", student_id: "12345", major1: "BIO", major2: "CSC", gender: "M", fed_group: "white", intern: "TRUE", research: "FALSE", service: "TRUE", career_related: "moderately", job_field: "consulting", FDS_cat: "employ", gs_select: "TRUE", gs_level: "doctoral", gs_type: "science")
  def setup
    @student = Student.create(class_year: 2018, student_id: "12345", major1: "BIO", major2: "CSC", gender: "M", fed_group: "white", intern: "TRUE", research: "FALSE", service: "TRUE", career_related: "moderately", job_field: "consulting", FDS_cat: "employ", gs_select: "TRUE", gs_level: "doctoral", gs_type: "science")
    @student1 = Student.create(class_year: 2005, student_id: "54321", major1: "MAT", major2: "CSC", gender: "M", fed_group: "white", intern: "TRUE", research: "FALSE", service: "TRUE", career_related: "moderately", job_field: "consulting", FDS_cat: "employ", gs_select: "TRUE", gs_level: "doctoral", gs_type: "science")
    @test_vis = Visualization.new(id: "1234", chart_type: "bar", x_axis_title: "Variable", y_axis_title: "Percentages", chart_title: "Visualization", created_at: "5:30", updated_at: "5:30")
    @test_vis.variables.build(id: "1234", name: "major1", role: "tasty")   # Builds the visualization first. Need to do this before saving to thet database!
    @test_vis.filters.build(variable_name: "major1", filter_type: "equals", value1: "BIO")
    @test_vis.save              # Saves to database
    @test_id = @test_vis.id
    #@Vis1 = Visualization.new(chart_title: "Dummy", x_axis_title: "x-axis", y_axis_title: "y-axis", chart_type: "bar")
    #@Vis2 = Visualization.new(chart_title: "Dummy", x_axis_title: "x-axis", y_axis_title: "y-axis", chart_type: "bar")
    #@Vis2.variables.new(name: "dingleberry", role: "fun") # add a variable to Vis2 to make it valid
    #@Vis2.filters = ['equals']
    #@Vis2.filters.build
    #@Vis2.variables.build
    #@Vis2.save
  end

  # Still need to test chart_info[:data]
  test "getting chart info" do
    chart_info = get_chart_info(@test_id)
    #assert (chart_info[:data] == @student && chart_info[:chart_type] == "bar" && chart_info[:options] == {:title=>"Visualization", :download=>true, :xtitle=>"Variable", :ytitle=>"Percentages", :donut=>true})
    # assert chart_info[:data] == [@student] 
    assert chart_info[:chart_type] == "bar" && chart_info[:options] == {:title=>"Visualization", :download=>true, :xtitle=>"Variable", :ytitle=>"Percentages", :donut=>true}
  end
  
  # why is this two
  test "apply_filter" do
    first_filter = @test_vis.filters.first # Built a filter which sees if major1 == "BIO"
    apply_filter(Student.all, first_filter)
    assert Student.all.count(:major1) == 2
  end
  
  
  # Testing the grouping
  # group_by_variable() takes in the database of all students, and @test_vis.variables.first, which is its first variable.
  # The method then checks some conditions and does Student.all.group(var.name). This var.name is "major1". See Line 10.
  # It returns a list of students grouped by major. We take the first student and tests if major1 == "BIO".
  test "grouping by variable" do
    assert group_by_variable(Student.all, @test_vis.variables.first).first.major1 == "BIO"
  end
  
  test "summarizing: count" do
    assert summarize(Student.all, 'count') == 2  # only two students in database
  end
  
  test "summarizing: sum" do
    assert summarize(Student.all, 'sum', 'class_year') == "4023"  # class years 2018 + 2005 = 4023. See Line 8 and 9
  end
  
  test "summarizing: max" do
    assert summarize(Student.all, 'max', 'class_year') == "2018" # largest class year is 2018. See Line 8 and 9
  end
  
  # default options for a chart. See Line 10
  test "getting chart options" do
    assert get_chart_options(@test_id) == {:title=>"Visualization", :download=>true, :xtitle=>"Variable", :ytitle=>"Percentages", :donut=>true} 
  end
  
  test "getting form filter values" do
    assert_not get_form_filter_values.empty?
  end
  
  test "shortening title over 45" do
    title = shorten_title("1111111111111111111111111111111111111111111111") 
    assert title = "111111111111111111111111111111111111111111111..."
  end
end