class CreateVisualizations < ActiveRecord::Migration[6.0]
  def change
    create_table :visualizations do |t|
      t.string :chart_type
      t.string :x_axis_title
      t.string :y_axis_title
      t.string :chart_title

      t.timestamps
    end
  end
end
