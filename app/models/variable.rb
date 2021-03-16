## Variable Model ##

## DOC OVERVIEW:
# This document defines the variable model, and runs basic validations for Char
# Variables field. Other validations can be found in other models, and general
# validations are in visualization.rb

## SPECIFIC VALIDATIONS:
# * The variable belongs to a visualization
# * That visualization exists
# * If either name or role is filled out, then so is the other.

## Tests are located in test/models/variable_test.rb

class Variable < ApplicationRecord
  belongs_to :visualization
  validates :name, presence: true, if: -> {role.present?}
  validates :role, presence: true, if: -> {name.present?}
  validates :visualization, presence: true
end
