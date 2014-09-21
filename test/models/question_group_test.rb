require 'test_helper'

class QuestionGroupTest < ActiveSupport::TestCase
  context 'A question_group' do
    should have_many :questions
    should validate_presence_of :name
  end
end
