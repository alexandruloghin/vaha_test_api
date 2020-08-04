class ExercisesController < BaseController
  before_action :authorize_trainer, only: :index

  def index
    render_response Exercise.all
  end

  def create
    exercise = Exercise.new(exercise_params)

    if exercise.save
      render_response exercise
    else
      render_error exercise.errors.full_messages
    end
  end

  private

  def exercise_params
    params.require(:exercise).permit(:name, :duration)
  end
end