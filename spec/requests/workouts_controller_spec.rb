require "rails_helper"

RSpec.describe WorkoutsController, type: :request do
	let(:trainer) { create(:trainer) }
	let(:trainee) { create(:trainee) }
	
	context "Trainer" do
		before do
			post '/auth/sign_in', params: { email: trainer.email, password: trainer.password }, as: :json
			@headers = {
	      'uid' => response.headers['uid'],
	      'client' => response.headers['client'],
	      'access-token' => response.headers['access-token']
	    }
		end

		it 'creates a workout' do
			post '/workouts', params: { workout: { name: "My first workout", state: :published } }, headers: @headers
			expect(response).to have_http_status(200)
			expect(trainer.workouts.count).to eq(1)
		end


	end
end