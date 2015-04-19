require 'rails_helper'

describe QuestionGroup do

  it { should have_many :questions }
  it { should validate_presence_of :name }

  describe 'scopes' do
    it "returns developer group" do
      question_group = FactoryGirl.create(:question_group)
      expect(QuestionGroup.dev).to eq [question_group]
    end

    it "returns company group" do
      question_group = FactoryGirl.create(:question_group, :name => 'company')
      expect(QuestionGroup.company).to eq [question_group]
    end

    it "returns general group" do
      question_group = FactoryGirl.create(:question_group, :name => 'general')
      expect(QuestionGroup.general).to eq [question_group]
    end
  end
  
end