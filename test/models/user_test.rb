require 'test_helper'

class UserTest < ActiveSupport::TestCase
  context 'a user' do
    should have_one :survey
  end
end
