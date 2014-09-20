require 'test_helper'

class SurveyTest < ActiveSupport::TestCase
  context 'A Survey' do
    should belong_to :user
    should validate_presence_of :user
  end
end
