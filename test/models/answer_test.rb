require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  context 'answer' do
    should belong_to :survey
    should belong_to :question
    should validate_presence_of :question

    should 'validate textfield if required' do
      question = FactoryGirl.build(:question, :required => true)
      answer = FactoryGirl.build_stubbed(:answer, :question => question)
      refute answer.valid?
      answer.text = 'test'
      assert answer.valid?
    end
  end
end
