class Variable < ApplicationRecord
  belongs_to :visualization
  #validates :name, presence: true
  #validates :role, presence: true
  #validates :visualization, presence: true
  #Commented out because only at least one variable is required for some charts.
end
