class CreateScores < ActiveRecord::Migration[5.0]
  def change
    create_table :scores do |t|
      t.references :round, foreign_key: true
      t.references :hole, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :strokes

      t.timestamps
    end
  end
end
