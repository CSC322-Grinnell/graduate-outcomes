## DOC OVERVIEW:
# This document runs basic validations for Chart Variables for field. Other
# validations can be found in other models, and general validations are in
# visualization.rb

## SPECIFIC VALIDATIONS:
# * The variable belongs to a visualization
# * That visualization exists
# * If either name or role is filled out, then so is the other.

class Variable < ApplicationRecord
  belongs_to :visualization
  validates :name, presence: true, if: -> {role.present?}
  validates :role, presence: true, if: -> {name.present?}
  validates :visualization, presence: true
end
