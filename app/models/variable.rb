class Variable < ApplicationRecord
  belongs_to :visualization
  validates :name, presence: true, if: -> {role.present?}
  validates :role, presence: true, if: -> {name.present?}
  validates :visualization, presence: true
end
