class BaseController < ApplicationController
  before_action :authenticate_user!
  respond_to :json

  protected

  def authorize_trainer
    unless current_user.is_a?(Trainer)
      render_unauthorized "You are not allowed to perform this action" 
      return false
    end
  end

  def authorize_trainee
    unless current_user.is_a?(Trainee)
      render_unauthorized "You are not allowed to perform this action" 
      return false
    end
  end

  def render_response data
  	render json: { data: data }, status: :ok
  end

  def render_error errors
    render json: { errors: errors }, status: :unprocessable_entity
  end

  def render_unauthorized message
    render json: { message: message }, status: :unauthorized
  end
end