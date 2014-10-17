class User < ActiveRecord::Base

  has_one :survey

  def admin?
    role == 'Admin'
  end

  def survey_completed?
    survey ? true : false
  end
end
