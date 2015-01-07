require 'test_helper'

class PossibleAnswerTest < ActiveSupport::TestCase
  should belong_to :question
  should have_many :answers
  should have_many :question_answer_choices
  should validate_presence_of :question
  should validate_presence_of :text
end
