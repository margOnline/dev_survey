require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  context 'answer' do
    should belong_to :survey
    should belong_to :question
    should have_many :question_answer_choices
    should have_many :possible_answers

    should validate_presence_of :question

    should 'validate textfield if required' do
      question = FactoryGirl.build(:question, :required => true)
      answer = FactoryGirl.build_stubbed(:answer, :question => question)
      refute answer.valid?
      answer.text = 'test'
      assert answer.valid?
    end

    should 'validate checkbox if required' do
      question = FactoryGirl.build(:question, :required => true,
        :field_type => 'Checkbox')
      answer = FactoryGirl.build_stubbed(:answer, :question => question)
      refute answer.valid?
      answer.question_answer_choices.create(:possible_answer =>
            FactoryGirl.create(:possible_answer))
      assert answer.valid?
    end

    should 'validate radio if required' do
      question = FactoryGirl.build(:question, :required => true,
        :field_type => 'RadioSelect')
      answer = FactoryGirl.build_stubbed(:answer, :question => question)
      refute answer.valid?
      answer.question_answer_choices.create(:possible_answer =>
         FactoryGirl.create(:possible_answer))
      assert answer.valid?
    end
  end
end
