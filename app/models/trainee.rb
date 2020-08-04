class Trainee < User
  has_many :trainee_assignments, dependent: :destroy
  has_many :trainers, through: :trainee_assignments
  has_many :workout_assignments, dependent: :destroy
  has_many :workouts, through: :workout_assignments
  has_many :workout_performances
end