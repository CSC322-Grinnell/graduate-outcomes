class Visualization < ApplicationRecord
  has_many :variables, inverse_of: :visualization
  accepts_nested_attributes_for :variables
  validates :chart_title, presence: true
  validates :x_axis_title, presence: true
  validates :y_axis_title, presence: true
  validates :chart_type, presence: true
end
