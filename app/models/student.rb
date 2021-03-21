class Student < ApplicationRecord
  require 'csv'
  # different attributes for each student, (note: currently all are required when uploading csv data)
  # descriptions of what each variable represents will be included above the variable (as some are not obvious)

  # class year
  validates :class_year, presence: true
  # id number
  validates :student_id, presence: true, uniqueness: true
  # first major
  validates :major1, presence: true
  # second major if they have one otherwise n/a
  validates :major2, presence: true
  # gender
  validates :gender, presence: true
  # ethnicity
  validates :fed_group, presence: true
  # have they had an internship (boolean)
  validates :intern, presence: true
  # have they done research (boolean)
  validates :research, presence: true
  # have they done service (boolean)
  validates :service, presence: true
  # how related is their career to their major
  validates :career_related, presence: true
  # field of their job
  validates :job_field, presence: true
  # first destination after graduating
  validates :FDS_cat, presence: true
  # stands for grad school selective (boolean or unknown)
  validates :gs_select, presence: true
  # grad school level (doctoral or master)
  validates :gs_level, presence: true
  # grad school type (e.g. science, humanities, etc.)
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
