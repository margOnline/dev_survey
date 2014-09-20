require 'test_helper'

class PossibleAnswerTest < ActiveSupport::TestCase
  should belong_to :question
  should validate_presence_of :question
  should validate_presence_of :text
end
