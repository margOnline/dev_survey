require 'test_helper'

class QuestionAnswerChoiceTest < ActiveSupport::TestCase
  context 'A question_answer_choice' do
    should belong_to :answer
    should belong_to :possible_answer

    should validate_presence_of :possible_answer
  end
end
