require 'rails_helper'

describe Token do
  it { should validate_uniqueness_of :code }

  describe "validate code prefix" do
    let(:token) { FactoryGirl.build(:token) }

    it "reject code if prefix is not Co or Dev" do
      token.code = 'dklfajdlfadfas334'
      expect(token.valid?).to eq false
    end

    it "accepts code with a prefix of Co or Dev" do
      expect(token.valid?).to eq true
    end
  end
end