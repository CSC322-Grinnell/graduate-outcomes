require 'test_helper'

class VisualizationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  # bar, line, pie
  def setup
    @Visualization = Visualization.new(chart_title: "Dummy", x_axis_title: "x-axis", y_axis_title: "y-axis", chart_type: "bar" )
  end
  
  test "Visualization should be valid" do
    assert @Visualization.valid?
  end
  
  test "chart title should be present" do
    @Visualization.chart_title = " "
    assert_not @Visualization.valid?
  end
  
  test "X axis title should be present" do
    @Visualization.x_axis_title = " "
    assert_not @Visualization.valid?
  end
  
  test "Y axis title should be present" do
    @Visualization.y_axis_title = " "
    assert_not @Visualization.valid?
  end
  
  test "Chart type should be present" do
    @Visualization.chart_type = " "
    assert_not @Visualization.valid?
  end
  
end
  
  
