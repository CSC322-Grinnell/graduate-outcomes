require 'test_helper'

class VariableTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @Visualization = Visualization.new(chart_title: "Dummy", x_axis_title: "x-axis", y_axis_title: "y-axis", chart_type: "bar" )
    @Variable = Variable.new(name: "dingleberry", role: "fun", visualization_id: @Visualization.id )
  end
  
  test "Variable should be valid" do
    assert @Variable.valid?
  end
  
   test "name should be present" do
    @Variable.name = " "
    assert_not @Variable.valid?
  end 
  
  test "role should be present" do
    @Variable.role = " "
    assert_not @Variable.valid?
  end
  
end
