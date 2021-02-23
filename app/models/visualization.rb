class Visualization < ApplicationRecord
  has_many :variables, inverse_of: :visualization
  has_many :filters, inverse_of: :visualization
  accepts_nested_attributes_for :variables, :filters
  validates :chart_title, presence: true
  validates :x_axis_title, presence: true
  validates :y_axis_title, presence: true
  validates :chart_type, presence: true
  validate :has_variable
  before_validation :chart_title_default
  
  private
  def chart_title_default
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

  def has_variable
    errors.add(:base, 'Requires at least one Chart Variable') if helper()
  end
  
  def helper()
    x = 0
    valid = true
    while x < self.variables.size and valid == true
      valid = (self.variables[x].name == "") && (self.variables[x].role == "")
      x = x + 1
    end
    return valid
  end
  
end
