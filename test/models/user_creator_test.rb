require 'test_helper'

class UserCreatorTest < ActiveSupport::TestCase

  context 'UserCreator' do
    setup do
      @args = { :filename => "Dev-token_codes.csv" }
      @filename = @args[:filename]
      @user_creator = UserCreator.new(@args)
    end

    should 'create users from the file data' do
      @user_creator.create!
      assert_equal 12, User.all.count
    end

  end

end
