class WorkoutPerformance < ApplicationRecord
	belongs_to :trainee
  belongs_to :workout

  validates :trainee_id, :workout_id, presence: true

  before_save :set_dates

  private

  def set_dates
    now             = DateTime.now
    self.started_at = now
    self.ended_at   = now + self.workout.total_duration.seconds
  end
end
