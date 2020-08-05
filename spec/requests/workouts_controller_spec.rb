require "rails_helper"

RSpec.describe WorkoutsController, type: :request do
	let(:trainer)   { create(:trainer, trainees: [create(:trainee)]) }
	let(:trainee)   { create(:trainee, workouts: create_list(:workout, 2, creator_id: trainer.id, state: :published)) }
  let(:workout)   { create(:workout, creator_id: trainer.id, state: :published) }
  let(:exercises) { create_list(:exercise, 2) }
	
	context "Trainer" do
		before do
			login_as(trainer)
		end

		it 'creates a workout' do
			post workouts_path, params: { workout: { name: "My first workout", state: :published } }, headers: @headers
			expect(response).to have_http_status(200)
			expect(trainer.workouts.count).to eq(1)
		end

    it 'updates a workout' do
      put workout_path(workout), params: { workout: { name: "My first workout", state: :draft } }, headers: @headers
      expect(response).to have_http_status(200)
      expect(workout.reload.name).to eq("My first workout")
      expect(workout.reload.state).to eq("draft")
    end

    it 'deletes a workout' do
      delete workout_path(workout), headers: @headers
      expect(response).to have_http_status(200)
      expect(trainer.workouts.count).to eq(0)
    end

    it 'views owned workouts' do
      my_workout = workout
      get workouts_path, headers: @headers
      expect(response).to have_http_status(200)
      response_data = JSON.parse(response.body)
      expect(response_data["data"].map{|o| o["id"]}).to match_array([workout.id])
    end

    it 'adds exercises to a workout' do
      post assign_exercises_workout_path(workout), params: { workout: { exercise_ids: exercises.map(&:id) } }, headers: @headers
      expect(response).to have_http_status(200)
      expect(workout.reload.exercises).to match_array(exercises)
      expect(workout.total_duration).to eq(exercises.map(&:duration).sum)
    end

    it 'assigns a workout to a trainee' do
      my_trainee = trainer.trainees.first
      post assign_to_trainees_workout_path(workout), params: { workout: { trainee_ids: [my_trainee.id] } }, headers: @headers
      expect(response).to have_http_status(200)
      expect(my_trainee.workouts.count).to eq(1)
    end
	end

  context "Trainee" do
    before do
      login_as(trainee)
    end

    it 'performs a workout' do
      my_workout = trainee.workouts.first
      get perform_workout_path(my_workout), headers: @headers
      expect(response).to have_http_status(200)
      expect(trainee.workout_performances.count).to eq(1)
    end

    it 'has an overview of workouts performed in a specific time period' do
      workout_1, workout_2 = trainee.workouts
      workout_1.exercises = exercises
      workout_2.exercises = exercises
      workout_1.save
      workout_2.save

      yesterday_beginning_of_day = DateTime.yesterday.beginning_of_day
      yesterday_end_of_day = DateTime.yesterday.end_of_day

      get perform_workout_path(workout_1), headers: @headers
      travel_to yesterday_beginning_of_day
      get perform_workout_path(workout_2), headers: @headers
      travel_back

      post overview_workouts_path, params: { start_date: yesterday_beginning_of_day.to_s(:db), end_date: yesterday_end_of_day.to_s(:db) }, headers: @headers
      response_data = JSON.parse(response.body)
      expect(response_data["data"].count).to eq(1)
      expect(response_data["data"].first["id"]).to eq(workout_2.id)

      post overview_workouts_path, params: { start_date: 1.hour.ago.to_s(:db), end_date: Time.now.end_of_day.to_s(:db) }, headers: @headers
      response_data = JSON.parse(response.body)
      expect(response_data["data"].count).to eq(1)
      expect(response_data["data"].first["id"]).to eq(workout_1.id)

      post overview_workouts_path, headers: @headers
      response_data = JSON.parse(response.body)
      expect(response_data["data"].count).to eq(2)
      expect(response_data["data"].map{|o| o["id"]}).to match_array([workout_1.id, workout_2.id])
    end
  end
end