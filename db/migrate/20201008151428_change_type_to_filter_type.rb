class ChangeTypeToFilterType < ActiveRecord::Migration[6.0]
  def change
    rename_column :filters, :type, :filter_type
  end
end
