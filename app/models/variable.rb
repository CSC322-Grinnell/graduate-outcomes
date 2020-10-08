class Variable < ApplicationRecord
  belongs_to :visualization
   validates :name, presence: true
   validates :role, presence: true
   validates :visualization, presence: true
end
