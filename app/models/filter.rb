## DOC OVERVIEW:
# This document runs basic validations for Filters field. Other validations
# can be found in other models, and general validations are in visualization.rb

## SPECIFIC VALIDATIONS:
# * A variable name is present if any fields are filled out
# * A filter type is present if any fields are filled out
# * At least one value (value1) is present if any fields are filled out
# * That visualization exists
# * If either name or role is filled out, then so is the other.

## Tests are located in test/models/filter_test.rb

class Filter < ApplicationRecord
  belongs_to :visualization
  validates :variable_name, presence: true, unless: -> { value1.blank? && filter_type.blank? && value2.blank? }
  validates :filter_type, presence: true, unless: -> { variable_name.blank? && value1.blank? && value2.blank? }
  validates :value1, presence: true, unless: -> { filter_type.blank? && variable_name.blank? && value2.blank? }
  # Filters conditions: 0 or more filters are allowed
end
