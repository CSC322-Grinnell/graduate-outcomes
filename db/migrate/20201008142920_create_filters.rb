class CreateFilters < ActiveRecord::Migration[6.0]
  def change
    create_table :filters do |t|
      t.references :visualization, null: false, foreign_key: true
      t.text :variable_name
      t.text :filter_type
      t.text :value1
      t.text :value2
      
      t.timestamps
    end
  end
end
