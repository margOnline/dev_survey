require 'test_helper'

class UserTest < ActiveSupport::TestCase
  context 'a user' do
    should have_one :survey
  end

  context 'methods' do
    setup { @user = FactoryGirl.create(:user) }

    should 'know if a user is an admin' do
      @admin = FactoryGirl.create(:user, :role => 'Admin')
      assert @admin.admin?
      refute @user.admin?
    end

    should 'know if survey has been completed' do
      user_with_survey = FactoryGirl.create(:user, :with_survey)
      refute @user.survey_completed?
      assert user_with_survey.survey_completed?
    end
  end
end
