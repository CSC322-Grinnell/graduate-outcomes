class Variable < ApplicationRecord
  belongs_to :visualization
  validates :name, presence: true, unless: -> { role.blank? }
  validates :role, presence: true, unless: -> { name.blank? }
  validates :visualization, presence: true
end
