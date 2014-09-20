require 'test_helper'

class SurveyTest < ActiveSupport::TestCase
  context 'A Survey' do
    should belong_to :user
    should validate_presence_of :user
    should have_many :answers
    should have_many :questions

    should 'validate all required questions are completed' do
      survey = FactoryGirl.create(:survey)
      question = FactoryGirl.create(:question, :required)
      answer = FactoryGirl.create(:answer,
        :survey => survey, :question => question, :text => 'ipsem lorem'
       )
      survey.reload.answers
      assert survey.valid?
    end
  end
end
