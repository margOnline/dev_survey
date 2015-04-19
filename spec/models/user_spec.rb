require 'rails_helper'

describe User do

  it { should have_one :survey }


  describe "methods" do
    before { @user = FactoryGirl.create(:user) }

    it "know if a user is an admin" do
      @admin = FactoryGirl.create(:user, :role => 'Admin')
      expect(@admin.admin?).to eq true
      expect(@user.admin?).to eq false
    end

    it "know if user is a dev" do
      dev_user = FactoryGirl.create(:user, :token => 'Dev34974484485')
      company_user = FactoryGirl.create(:user, :token => 'Co34974484485')
      expect(company_user.dev?).to eq false
      expect(dev_user.dev?).to eq true
    end

    it "know if survey has been completed" do
      user_with_survey = FactoryGirl.create(:user, :with_survey)
      expect(@user.survey_completed?).to eq false
      expect(user_with_survey.survey_completed?).to eq true
    end
  end
end