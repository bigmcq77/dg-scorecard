class CreateHoles < ActiveRecord::Migration[5.0]
  def change
    create_table :holes do |t|
      t.references :course, foreign_key: true
      t.integer :number
      t.integer :par

      t.timestamps
    end
  end
end
