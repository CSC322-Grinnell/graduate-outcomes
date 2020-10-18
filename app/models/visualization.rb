class Visualization < ApplicationRecord
  has_many :filters, :variables, inverse_of: :visualization
  validates :chart_title, presence: true
  validates :x_axis_title, presence: true
  validates :y_axis_title, presence: true
  validates :chart_type, presence: true
  has_many :filters, inverse_of: :visualization
  accepts_nested_attributes_for :variables, :filters
end
