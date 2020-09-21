class Student < ApplicationRecord
  validates :class_year, presence: true
  validates :student_id, presence: true
  validates :major1, presence: true
  validates :major2, presence: true
  validates :gender, presence: true
  validates :fed_group, presence: true
  validates :intern, presence: true
  validates :research, presence: true
  validates :service, presence: true
  validates :career_related, presence: true
  validates :job_field, presence: true
end