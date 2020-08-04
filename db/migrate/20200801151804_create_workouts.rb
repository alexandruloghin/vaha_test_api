class CreateWorkouts < ActiveRecord::Migration[6.0]
  def change
    create_table :workouts do |t|
      t.string :name
      t.integer :creator_id
      t.integer :total_duration
      t.integer :state

      t.timestamps
    end
  end
end
