require 'test_helper'

class TokenCodeGeneratorTest < ActiveSupport::TestCase

  context 'TokenCodeGenerator' do
    setup do
      @args = { :prefix => 'Co', :number => 2 }
      @prefix = @args[:prefix]
      @tcg = TokenCodeGenerator.new(@args)
    end


    should 'create a code from the prefix followed by 10 random alphanumerics' do
      assert_match /^#{@prefix}[\w]{10}/, @tcg.send(:create_token_code)
    end

    should 'create a token' do
      assert_instance_of Token, @tcg.create_token
    end

    should 'create a csv file with the correct number of token codes' do
      csv_path = "#{Rails.root}/tmp/#{@prefix}-token_codes-#{Date.today}.csv"
      @tcg.generate_token_codes
      assert_equal @args[:number], File.readlines(csv_path).count
      File.delete(csv_path)
    end
  end

end
