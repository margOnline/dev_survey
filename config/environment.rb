PROJECT_NAME = 'dev_survey'
BRAND_NAME   = 'Developer Survey'
app_version = `git log -1 --pretty='format:%h (%ci)' 2>/dev/null`
APP_VERSION  = app_version.strip rescue 'unknown'
# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
DevSurvey::Application.initialize!
