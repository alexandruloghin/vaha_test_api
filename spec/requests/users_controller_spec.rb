require "rails_helper"
require "helpers"

RSpec.configure do |c|
  c.include Helpers
end

RSpec.describe WorkoutsController, type: :request do
  let!(:trainer)      { create(:trainer, trainees: create_list(:trainee, 2)) }
  let!(:yoga_trainer) { create(:trainer, expertise: "yoga") }
  let(:trainee)      { create(:trainee) }

  context "Trainer" do
    before do
      login_as(trainer)
    end

    it 'views selected trainees' do
      get '/trainees', headers: @headers
      expect(response).to have_http_status(200)
      response_data = JSON.parse(response.body)
      expect(response_data["data"].count).to eq(2)
      expect(response_data["data"].map{|o| o["id"]}).to match_array(trainer.trainees.map(&:id))
    end
  end

  context "Trainee" do
    before do
      login_as(trainee)
    end

    it 'views all trainers' do
      post '/trainers', headers: @headers
      expect(response).to have_http_status(200)
      response_data = JSON.parse(response.body)
      expect(response_data["data"].count).to eq(2)
      expect(response_data["data"].map{|o| o["id"]}).to match_array([trainer.id, yoga_trainer.id])
    end

    it 'views/searches trainers based on expertise' do
      post '/trainers', params: { expertise: "yoga"},  headers: @headers
      expect(response).to have_http_status(200)
      response_data = JSON.parse(response.body)
      expect(response_data["data"].count).to eq(1)
      expect(response_data["data"].map{|o| o["id"]}).to match_array([yoga_trainer.id])
    end
  end
end