class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery

  private
  def after_sign_in_path_for(resource)
    new_survey_path(resource)
  end
end
