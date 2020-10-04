class Visualization < ApplicationRecord
  has_many :variables, inverse_of: :visualization
  accepts_nested_attributes_for :variables
end
