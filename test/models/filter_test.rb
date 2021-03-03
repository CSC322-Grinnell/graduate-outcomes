## Tests for filter validations from app/models/filter.rb

require 'test_helper'

class FilterTest < ActiveSupport::TestCase

  # Initialize six test filters, a variety of valid and invalid
  def setup
    @visualization = Visualization.new()
    # filter1: valid; all fields filled
    @filter1 = @visualization.filters.new(variable_name:"major1", filter_type:"equals", value1:"Computer Science",  value2:"Sociology")
    
    # filter2: invalid; missing filter_type and value1
    @filter2 = @visualization.filters.new(variable_name:"gender")
    
    # filter3: valid; lacks value2, but that's not a required field
    @filter3 = @visualization.filters.new(variable_name:"gender", filter_type:"equals", value1:"F")
    
    # filter4: invalid; missing filter_type and value1, has value2
    @filter4 = @visualization.filters.new(variable_name:"gender", value2:"M")
    
    # filter5: invalid; missing variable_name and value1
    @filter5 = @visualization.filters.new(filter_type:"equals")
    
    # filter6: invalid; missing all required fields, but value2 is selected
    @filter6 = @visualization.filters.new(value2:"M")
  end

  # Assert that each filter is valid or invalid as intended
  test "should create filter" do
    assert @filter1.valid?
    assert_not @filter2.valid?
    assert @filter3.valid?
    assert_not @filter4.valid?
    assert_not @filter5.valid?
    assert_not @filter6.valid?
  end

end
