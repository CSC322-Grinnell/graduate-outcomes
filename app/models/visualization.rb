## DOC OVERVIEW:
# This document runs basic validations for all form fields when creating/editing
# a visualization. Further validations for specific fields are in other models,
# such as variable.rb and filter.rb

## SPECIFIC VALIDATIONS:
# * There are multiple Chart Variables and Filters on the form
#    * These do not all need to be filled in by the user
# * It is okay to have overlapping attributes for Chart Variables and Filters
# * There are titles for the chart, x-axis, and y-axis
#    * Note: these are auto-filled if not filled in by the user. This validates.
# * User has selected at least one Chart Variable

class Visualization < ApplicationRecord
  has_many :variables, inverse_of: :visualization # many slots for chart vars
  has_many :filters, inverse_of: :visualization   # many slots for filters
  accepts_nested_attributes_for :variables, :filters # attributes for vars and
                                                     # filters can overlap
  validates :chart_title, presence: true  # chart titles exist
  validates :x_axis_title, presence: true
  validates :y_axis_title, presence: true
  validates :chart_type, presence: true   # chart type chosen by user
  validate :has_variable                  # at least one chart var selected
  before_validation :chart_title_default  # run title autofill before validating
  
  private
  def chart_title_default # auto-fill chart titles if no user input
    if chart_title.empty?
      self.chart_title = "Visualization"
    end
    
    if x_axis_title.empty?
      self.x_axis_title = "Variable"
    end
    
    if y_axis_title.empty?
      self.y_axis_title = "Count"
    end
  end

  def has_variable # checks at least one chart var has been selected by user
    errors.add(:base, 'Requires at least one Chart Variable') if helper()
  end
  
  def helper() # returns true if no vars selected, false if at least one exists
    x = 0
    valid = true
    while x < self.variables.size and valid == true
      valid = (self.variables[x].name == "") && (self.variables[x].role == "")
      x = x + 1
    end
    return valid
  end
  
end
