require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  context 'question' do
    should have_many :answers
    should have_many :possible_answers
    should belong_to :question_group

    should validate_presence_of :title
    should validate_presence_of :field_type
    should allow_value('TextField', 'RadioSelect', 'Checkbox', 'Textarea').for(:field_type)
    should_not allow_value('Ipsem').for(:field_type)

    context 'class methods' do
      setup do
        @dev_question = FactoryGirl.create(:question, :for_developer)
        @company_question = FactoryGirl.create(:question, :for_company)
        @general_question = FactoryGirl.create(:question, :general)
      end

      should 'return questions for devs' do
        assert Question.for_developer.include?(@dev_question)
        refute Question.for_developer.include?(@company_question)
        refute Question.for_developer.include?(@general_question)
      end

      should 'return questions for company' do
        assert Question.for_company.include?(@company_question)
        refute Question.for_company.include?(@dev_question)
        refute Question.for_company.include?(@general_question)
      end

      should 'return general questions' do
        assert Question.general.include?(@general_question)
        refute Question.general.include?(@dev_question)
        refute Question.general.include?(@company_question)
      end
    end
  end
end
