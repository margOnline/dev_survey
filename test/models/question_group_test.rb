require 'test_helper'

class QuestionGroupTest < ActiveSupport::TestCase
  context 'A question_group' do
    should have_many :questions
    should validate_presence_of :name

    context 'scopes' do
      should 'return developer group' do
        question_group = FactoryGirl.create(:question_group)
        assert_equal QuestionGroup.dev, [question_group]
      end

      should 'return company group' do
        question_group = FactoryGirl.create(:question_group, :name => 'company')
        assert_equal QuestionGroup.company, [question_group]
      end

      should 'return general group' do
        question_group = FactoryGirl.create(:question_group, :name => 'general')
        assert_equal QuestionGroup.general, [question_group]
      end
    end
  end
end
