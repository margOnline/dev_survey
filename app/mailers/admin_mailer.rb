class AdminMailer < ActionMailer::Base
  include Sidekiq::Worker

  default :from => "Developer Survey<support@#{default_url_options[:host]}>"

  def notify_admin(survey_id)
    @survey = Survey.find(survey_id)
    mail(:to => ENV['ADMIN_EMAIL'], :subject => "Survey Completed")
  end
end
