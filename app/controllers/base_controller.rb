class BaseController < ApplicationController
  before_action :authenticate_user!
  respond_to :json

  protected

  ["trainer", "trainee"].each do |user_type|
    define_method "authorize_#{user_type}" do
      unless current_user.is_a?(user_type.capitalize.constantize)
        render_unauthorized "You are not allowed to perform this action" 
        return false
      end
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