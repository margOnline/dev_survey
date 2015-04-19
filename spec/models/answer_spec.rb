require 'rails_helper'

describe Answer do
  describe "associations" do
    it { should belong_to :survey }
    it { should belong_to :question }
    it { should have_many :question_answer_choices }
    it { should have_many :possible_answers }
  end

  describe "validations" do
    it {should validate_presence_of :question }

    it "validates textfield if required" do
      question = FactoryGirl.build(:question, required: true)
      answer = FactoryGirl.build_stubbed(:answer, question: question)
      expect(answer.valid?).to eq false
      answer.text = 'test'
      expect(answer.valid?).to eq true
    end

    it "validate checkbox if required" do
      question = FactoryGirl.build(:question, required: true,
        :field_type => 'Checkbox')
      answer = FactoryGirl.build_stubbed(:answer, question: question)
      expect(answer.valid?).to eq false
      answer.question_answer_choices.create(possible_answer:
            FactoryGirl.create(:possible_answer))
      expect(answer.valid?).to eq true
    end

    it "validate radio if required" do
      question = FactoryGirl.build(:question, required: true,
        :field_type => 'RadioSelect')
      answer = FactoryGirl.build_stubbed(:answer, question: question)
      expect(answer.valid?).to eq false
      answer.question_answer_choices.create(possible_answer:
         FactoryGirl.create(:possible_answer))
      expect(answer.valid?).to eq true
    end
  end
end