require 'test_helper'

class TokenTest < ActiveSupport::TestCase
  should validate_uniqueness_of :code

  context 'validate code prefix' do
    setup { @token = FactoryGirl.build(:token) }

    should 'reject code if prefix is not Co or Dev' do
      @token.code = 'dklfajdlfadfas334'
      refute @token.valid?
    end

    should 'accept code with a prefix of Co or Dev' do
      assert @token.valid?
    end
  end
end
