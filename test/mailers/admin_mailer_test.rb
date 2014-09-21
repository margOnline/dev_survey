require 'test_helper'

class AdminMailerTest < ActionMailer::TestCase
  context 'AdminMailer' do
    should 'send notification to admin when a survey has been created' do
      @survey = FactoryGirl.create(:survey)
      AdminMailer.notify_admin(@survey).deliver
      notification_email = ActionMailer::Base.deliveries.last
      assert_equal 'Survey Completed', notification_email.subject
    end
  end
end
