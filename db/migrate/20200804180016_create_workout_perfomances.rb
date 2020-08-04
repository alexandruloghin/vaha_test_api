class CreateWorkoutPerfomances < ActiveRecord::Migration[6.0]
  def change
    create_table :workout_perfomances do |t|
      t.integer :trainee_id
      t.integer :workout_id
      t.datetime :started_at
      t.datetime :ended_at

      t.timestamps
    end
  end
end
