require 'test_helper'

class UserTest < ActiveSupport::TestCase
  context 'a user' do
    should have_one :survey
  end

  context 'roles' do
    should 'know if a user is an admin' do
      user = FactoryGirl.create(:user)
      admin = FactoryGirl.create(:user, :role => 'Admin')
      assert admin.admin?
      refute user.admin?
    end
  end
end
