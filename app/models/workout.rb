class Workout < ApplicationRecord
	belongs_to :trainer, foreign_key: 'creator_id'
  has_many :exercise_lists, dependent: :destroy
  has_many :exercises, through: :exercise_lists
  has_many :workout_assignments, dependent: :destroy
  has_many :trainees, through: :workout_assignments
  has_many :workout_performances

  validates :name, :creator_id, :state, presence: true

  enum state: [:draft, :published]

  before_save :set_total_duration

  private

  def set_total_duration
    self.total_duration = self.exercises.map(&:duration).sum
  end
end