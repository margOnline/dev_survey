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

    should 'notify admin when survey is saved' do
      @survey = FactoryGirl.build(:survey)
      @survey.save
      mock = flexmock(:mailer) do |mock|
        mock.should_receive(:deliver).once.and_return(true)
      end
      flexmock(AdminMailer).should_receive(:notify_admin).once.with(@survey.id).
        and_return(mock)
      @survey.run_callbacks(:commit)
    end

    should 'return answers indexed by question' do
      survey = FactoryGirl.build(:survey)
      question1 = FactoryGirl.create(:question)
      question2 = FactoryGirl.create(:question)
      answer1 = FactoryGirl.create(:answer, survey: survey, question: question2, text: 'ipsem')
      answer2 = FactoryGirl.create(:answer, survey: survey, question: question1, text: 'ipsem')
      answer3 = FactoryGirl.create(:answer, survey: survey, question: question2, text: 'ipsem')
      assert_equal survey.answers_by_question, {question1 => [answer2], question2 => [answer1, answer3]}
    end
  end
end
