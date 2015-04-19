require 'rails_helper'

describe UserCreator do
  before do
    @args = { :filename => "Dev-token_codes.csv" }
    @filename = @args[:filename]
    @user_creator = UserCreator.new(@args)
  end

  it "creates users from the file data" do
    @user_creator.create!
    expect(User.all.count).to eq 12
  end

end