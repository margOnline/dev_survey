class User < ActiveRecord::Base

  has_one :survey

  def admin?
    role == 'Admin'
  end

  def token_used?
    user.token
  end
end
