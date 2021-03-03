class Student < ApplicationRecord
  require 'csv'

  validates :class_year, presence: true
  validates :student_id, presence: true, uniqueness: true
  validates :major1, presence: true
  validates :major2, presence: true
  validates :gender, presence: true
  validates :fed_group, presence: true
  validates :intern, presence: true
  validates :research, presence: true
  validates :service, presence: true
  validates :career_related, presence: true
  validates :job_field, presence: true
  validates :FDS_cat, presence: true
  validates :gs_select, presence: true
  validates :gs_level, presence: true
  validates :gs_type, presence: true

  # Class method import with file passed through as an argument
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      s = Student.new(row.to_hash)
      puts(s.class_year)
      Student.create(row.to_hash)
    end
  end
end
