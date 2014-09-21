class AdminMailer < ActionMailer::Base
  include Sidekiq::Worker

  default :from => "Developer Survey<support@#{default_url_options[:host]}>"

  def notify_admin(survey_id)
    @survey = Survey.find(survey_id)
    mail(:to => 'margo@mintdigital.com', :subject => "Survey Completed")
  end
end
