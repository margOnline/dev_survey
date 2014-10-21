class AdminMailer < ActionMailer::Base
  include Sidekiq::Worker

  default :from => "Developer Survey<support@#{default_url_options[:host]}>"

  def notify_admin(survey_id)
    @survey = Survey.find(survey_id)
    Rails.logger.info("\n\n ***** EMAIL Sent now to #{ENV['ADMIN_EMAIL']} ***** \n\n")
    mail(:to => ENV['ADMIN_EMAIL'], :subject => "Survey Completed")
  end
end
