class RenameWorkoutPerformancesTabes < ActiveRecord::Migration[6.0]
  def change
  	rename_table :workout_perfomances, :workout_performances
  end
end
