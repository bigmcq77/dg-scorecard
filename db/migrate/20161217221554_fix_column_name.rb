class FixColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :courses, :holes, :num_holes
  end
end
