## Tests for visualization validations from app/models/visualization.rb

require 'test_helper'

class VisualizationTest < ActiveSupport::TestCase

  # Initialze two visualizations, one invalid and one valid
  def setup
    @student = Student.create(class_year: "2018", student_id: "12345", major1: "BIO", major2: "CSC", gender: "M", fed_group: "white", intern: "TRUE", research: "FALSE", service: "TRUE", career_related: "moderately", job_field: "consulting", FDS_cat: "employ", gs_select: "TRUE", gs_level: "doctoral", gs_type: "science")
    @Vis1 = Visualization.new(chart_title: "Dummy", x_axis_title: "x-axis", y_axis_title: "y-axis", chart_type: "bar")
    @Vis2 = Visualization.new(chart_title: "Dummy", x_axis_title: "x-axis", y_axis_title: "y-axis", chart_type: "bar")
    @Vis2.variables.build(name: "dingleberry", role: "fun") # add a variable to Vis2 to make it valid
  end

  # Due to lacking any variables, Vis1 should be invalid
  test "Vis1 should not be valid without any variables" do
    assert_not @Vis1.valid?
  end

  test "Vis2 should not be valid without any data" do
    @student.destroy
    assert_not @Vis2.valid?
  end
  
  # Vis2 should be valid
  test "Vis2 should be valid" do
    assert @Vis2.valid?
  end

  # Removing the chart_title, Vis2 should auto-fill this field and be valid
  test "chart title should auto-fill" do
    @Vis2.chart_title = ""
    assert @Vis2.valid?
  end

  # Removing the x_axis_title, Vis2 should auto-fill this field and be valid
  test "X axis title should auto-fill" do
    @Vis2.x_axis_title = ""
    assert @Vis2.valid?
  end

  # Removing the y_axis_title, Vis2 should auto-fill this field and be valid
  test "Y axis title should auto-fill" do
    @Vis2.y_axis_title = ""
    assert @Vis2.valid?
  end

  # Removing the chart_type, Vis2 should now be invalid
  test "Chart type should be present" do
    @Vis2.chart_type = ""
    assert_not @Vis2.valid?
  end
  
end
  
  
