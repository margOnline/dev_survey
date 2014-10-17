class User < ActiveRecord::Base

  has_one :survey

  def admin?
    role == 'Admin'
  end

  def dev?
    token[0,3] == 'Dev'
  end

  def survey_completed?
    survey ? true : false
  end
end
