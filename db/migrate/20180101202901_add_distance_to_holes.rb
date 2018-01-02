class AddDistanceToHoles < ActiveRecord::Migration[5.0]
  def change
    add_column :holes, :distance, :string
  end
end
