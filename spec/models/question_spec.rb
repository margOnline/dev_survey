require 'rails_helper'

describe Question do
  describe "associations" do
    it { should have_many :answers }
    it { should have_many :possible_answers }
    it { should belong_to :question_group }
  end
    
  describe "validations" do
    it { should validate_presence_of :question_group }
    it { should validate_presence_of :title }
    it { should validate_presence_of :field_type }
    it { should validate_uniqueness_of :position}
    it {should validate_numericality_of :position}
    it { should allow_value('TextField', 'RadioSelect', 'Checkbox', 'Textarea').for(:field_type) }
    it { should_not allow_value('Ipsem').for(:field_type) }
  end

  describe "class methods" do
    before do
      @dev_question = FactoryGirl.create(:question, :for_dev, position: 2)
      @company_question = FactoryGirl.create(:question, :for_company, position: 3)
      @general_question = FactoryGirl.create(:question, :general, position: 1)
    end

    it "returns questions for devs" do
      expect(Question.for_dev.include?(@dev_question)).to eq true
      expect(Question.for_dev.include?(@company_question)).to eq false
      expect(Question.for_dev.include?(@general_question)).to eq false
    end

    it "returns questions for company" do
      expect(Question.for_company.include?(@company_question)).to eq true
      expect(Question.for_company.include?(@dev_question)).to eq false
      expect(Question.for_company.include?(@general_question)).to eq false
    end

    it "returns general questions" do
      expect(Question.general.include?(@general_question)).to eq true
      expect(Question.general.include?(@dev_question)).to eq false
      expect(Question.general.include?(@company_question)).to eq false
    end

    it "returns questions in ascending order by position" do
      expect(Question.by_position).to eq [@general_question, @dev_question, @company_question]
    end
  end

end