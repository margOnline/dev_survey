require 'rails_helper'

describe AdminMailer do
  it "emails admin when a survey has been created" do
    @survey = FactoryGirl.create(:survey)
    AdminMailer.notify_admin(@survey.id).deliver_later
    notification_email = ActionMailer::Base.deliveries.last
    expect(notification_email.subject).to eq 'Survey Completed'
  end
end