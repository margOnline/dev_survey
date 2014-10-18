require 'test_helper'

class UserCreatorTest < ActiveSupport::TestCase

  context 'UserCreator' do
    setup do
      @filename = "#{Rails.root}/tmp/Dev-token_codes.csv"
      @user_creator = UserCreator.new(@args)
    end

    should 'create users from the file data' do
      assert_equal 12, User.all.count
    end

  end

end
