class CreateTraineeAssignments < ActiveRecord::Migration[6.0]
  def change
    create_table :trainee_assignments do |t|
      t.integer :trainer_id
      t.integer :trainee_id

      t.timestamps
    end
  end
end
