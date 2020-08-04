class ApplicationController < ActionController::Base
  protect_from_forgery unless: -> { request.format.json? }

  include DeviseTokenAuth::Concerns::SetUserByToken
  
  before_action :add_permitted_parameters, if: :devise_controller?

  respond_to :json

  def add_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:type, :expertise, :name, :nickname])
  end
end
