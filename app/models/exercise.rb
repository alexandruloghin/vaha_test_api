class Exercise < ApplicationRecord
	has_many :exercise_lists, dependent: :destroy
  has_many :workouts, through: :exercise_lists

  validates :name, :duration, presence: true
  validates :duration, numericality: { only_integer: true, greather_than: 0 }
end
