require 'rails_helper'

describe TokenCodeGenerator do

  before do
    @args = { :prefix => 'Co', :number => 2 }
    @prefix = @args[:prefix]
    @tcg = TokenCodeGenerator.new(@args)
  end


  it "creates a code from the prefix followed by 10 random alphanumerics" do
    expect(@tcg.send(:create_token_code)).to match /^#{@prefix}[\w]{10}/
  end

  it "creates a token" do
    expect(@tcg.create_token).to be_a Token
  end

  it "creates a csv file with the correct number of token codes" do
    csv_path = "#{Rails.root}/tmp/#{@prefix}-token_codes-#{Date.today}.csv"
    @tcg.generate_token_codes
    expect(File.readlines(csv_path).count).to eq @args[:number]
    File.delete(csv_path)
  end

end