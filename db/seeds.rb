# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'dummy_data.csv'))

csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')

csv.each do |row|
  s = Student.new
  s.class_year = row['class_year']
  s.student_id = row['student_id']
  s.major1 = row['major1']
  s.major2 = row['major2']
  s.gender = row['gender']
  s.fed_group = row['fed_group']
  s.intern = row['intern']
  s.research = row['research']
  s.service = row['service']
  s.career_related = row['career_related']
  s.job_field = row['job_field']
  s.save
end

puts "There are now #{Student.count} records stored"

User.create({email: 'barks@grinnell.edu', password:'gradoutcomes', password_confirmation:'gradoutcomes'})