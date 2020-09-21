class CreateStudents < ActiveRecord::Migration[6.0]
  def change
    create_table :students do |t|
      t.string :class_year
      t.string :student_id
      t.string :major1
      t.string :major2
      t.string :gender
      t.string :fed_group
      t.string :intern
      t.string :research
      t.string :service
      t.string :career_related
      t.string :job_field

      t.timestamps
    end
  end
end
