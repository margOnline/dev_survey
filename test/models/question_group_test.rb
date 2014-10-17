require 'test_helper'

class QuestionGroupTest < ActiveSupport::TestCase
  context 'A question_group' do
    should have_many :questions
    should validate_presence_of :name

    context 'scopes' do
      setup do
        @dev_question = FactoryGirl.create(:question, :for_dev)
        @company_question = FactoryGirl.create(:question, :for_company)
        @general_question = FactoryGirl.create(:question)
      end

      should 'return questions for devs' do
        assert Question.for_dev.include?(@dev_question)
        refute Question.for_dev.include?(@company_question)
        refute Question.for_dev.include?(@general_question)
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
