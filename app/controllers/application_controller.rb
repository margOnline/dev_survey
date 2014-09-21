class ApplicationController < ActionController::Base

  protect_from_forgery

  private
  def after_sign_in_path_for(resource)
    new_user_survey_path(resource)
  end
end
