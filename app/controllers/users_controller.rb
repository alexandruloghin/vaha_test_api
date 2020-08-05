class UsersController < BaseController
  before_action :authorize_trainer, only: :trainees

  def trainees
    render_response current_user.trainees
  end

  def trainers
    trainers = Trainer.all
    
    if params[:expertise].present?
      trainers = trainers.where(expertise: params[:expertise])
    end
    
    render_response trainers
  end

  def choose_trainers
    trainers = Trainer.find(params[:trainer_ids]) rescue nil
    if trainers.present?
      current_user.trainers = trainers
      current_user.save
      render_response current_user.trainers
    else
      render_error "Could not find trainers"
    end
  end
end