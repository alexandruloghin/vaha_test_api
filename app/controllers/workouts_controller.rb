class WorkoutsController < BaseController
  before_action :authorize_trainer, except: [:index, :perform, :overview]
  before_action :authorize_trainee, only: [:perform, :overview]
  before_action :load_workout, except: [:index, :create, :overview]

  def index
    render_response current_user.workouts
  end

  def create
    workout = current_user.workouts.new(workout_params)

    if workout.save
      render_response workout
    else
      render_error workout.errors.full_messages
    end
  end

  def update
    if @workout.update_attributes(workout_params)
      render_response @workout
    else
      render_error @workout.errors.full_messages
    end
  end

  def assign_exercises
    exercises = Exercise.find(workout_params[:exercise_ids]) rescue nil
    if exercises.present?
      @workout.exercises = exercises
      @workout.save
      render_response @workout.exercises
    else
      render_error "Could not find exercises"
    end
  end

  def show
    render_response @workout
  end

  def exercises
    render_response @workout.exercises
  end

  def trainees
    render_response @workout.trainees
  end

  def assign_to_trainees
    trainees = Trainee.find(workout_params[:trainee_ids]) rescue nil
    if trainees.present?
      @workout.trainees = trainees
      @workout.save
      render_response @workout.trainees
    else
      render_error "Could not find trainees"
    end
  end

  def perform
    render_error "Cannot perform unassigned workout" and return unless current_user.workouts.include?(@workout)

    performance = current_user.workout_performances.new(workout_id: @workout.id)
    if performance.save
      render_response performance
    else
      render_error performance.errors.full_messages
    end
  end

  def overview
    performances = current_user.workout_performances

    if params[:start_date].present?
      performances = performances.where("started_at >= ?", params[:start_date])
    end

    if params[:end_date].present?
      performances = performances.where("ended_at <= ?", params[:end_date])
    end

    render_response performances.map(&:workout).uniq
  end

  def destroy
    if @workout.destroy
      render_response "Workout with id #{@workout.id} successfully destroyed"
    else
      render_error "There has been an error destroying workout with id #{@workout.id}"
    end
  end

  private

  def load_workout
    @workout = Workout.find(params[:id]) rescue nil
    unless @workout
      render_error "Could not find record with id #{params[:id]}"
      return false
    end
  end

  def workout_params
    params.require(:workout).permit(:name, :state, exercise_ids: [], trainee_ids: [])
  end
end