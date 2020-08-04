class CreateExerciseLists < ActiveRecord::Migration[6.0]
  def change
    create_table :exercise_lists do |t|
      t.integer :workout_id
      t.integer :exercise_id

      t.timestamps
    end
  end
end
