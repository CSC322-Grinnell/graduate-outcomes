require 'test_helper'

class FilterTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @visualization = Visualization.new()
    @filter = @visualization.filters.new(variable_name:"major1", filter_type:"equals", value1:"Computer Science",  value2:"Sociology")
  end

  test "should create filter" do
    assert @filter.valid?
  end

end
