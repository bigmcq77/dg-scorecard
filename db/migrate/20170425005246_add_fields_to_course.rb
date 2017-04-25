class AddFieldsToCourse < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :city, :string
    add_column :courses, :state, :string
    add_column :courses, :basket_type, :string
    add_column :courses, :tee_type, :string
  end
end
