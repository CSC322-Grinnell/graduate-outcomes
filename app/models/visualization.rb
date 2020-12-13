class Visualization < ApplicationRecord
  has_many :variables, inverse_of: :visualization
  has_many :filters, inverse_of: :visualization
  accepts_nested_attributes_for :variables, :filters
  validates :chart_title, presence: true
  validates :x_axis_title, presence: true
  validates :y_axis_title, presence: true
  validates :chart_type, presence: true
  before_validation :chart_title_default, :x_axis_title_default, :y_axis_title_default
  
  private
  def chart_title_default
    if chart_title.empty?
      self.chart_title = "Visualization"
    end
  end
  def x_axis_title_default
    if x_axis_title.empty?
      self.x_axis_title = "Variable"
    end
  end
  
  def y_axis_title_default
    if y_axis_title.empty?
      self.y_axis_title = "Count"
    end
  end
  
end