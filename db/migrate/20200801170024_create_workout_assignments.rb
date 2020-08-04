class CreateWorkoutAssignments < ActiveRecord::Migration[6.0]
  def change
    create_table :workout_assignments do |t|
      t.integer :trainee_id
      t.integer :workout_id

      t.timestamps
    end
  end
end
