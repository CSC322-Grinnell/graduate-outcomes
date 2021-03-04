## Tests for variable validations from app/models/variable.rb

require 'test_helper'

class VariableTest < ActiveSupport::TestCase

  # Initialize test visualization with valid variable dingleberry
  def setup
    @Visualization = Visualization.new(chart_title: "Dummy", x_axis_title: "x-axis", y_axis_title: "y-axis", chart_type: "bar" )
    @Variable = @Visualization.variables.new(name: "dingleberry", role: "fun", visualization_id: @Visualization.id )
  end

  # Assert test variable is valid
  test "Variable should be valid" do
    assert @Variable.valid?
  end

  # Remove name and assert no longer valid
  test "name should be present" do
    @Variable.name = ""
    assert_not @Variable.valid?
  end 

  # Remove role and assert no longer valid
  test "role should be present" do
    @Variable.role = ""
    assert_not @Variable.valid?
  end
  
end
