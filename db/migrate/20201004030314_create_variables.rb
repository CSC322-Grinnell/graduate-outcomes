class CreateVariables < ActiveRecord::Migration[6.0]
  def change
    create_table :variables do |t|
      t.belongs_to :visualization, index: true
      t.string :name
      t.string :role

      t.timestamps
    end
  end
end
