class Trainer < User
  has_many :workouts, foreign_key: 'creator_id'
  has_many :trainee_assignments, dependent: :destroy
  has_many :trainees, through: :trainee_assignments

  validates :expertise, presence: true
end