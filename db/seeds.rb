# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'dummy_data3.csv'))

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
  s.FDS_cat = row['FDS_cat']
  s.gs_select = row['gs_select']
  s.gs_level = row['gs_level']
  s.gs_type = row['gs_type']

  s.save
end

puts "There are now #{Student.count} records stored"
=======
#Adds Sarah to the approved emails database (must be first step!)
ValidEmail.create({email: 'barks@grinnell.edu'})

#Adds Sarah's login info to the users database
User.create({email: 'barks@grinnell.edu', password:'gradoutcomes', password_confirmation:'gradoutcomes'})
>>>>>>> d80fd111a4f1feaffa9dc086ab2d93eb76699164
