require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  context 'question' do
    should have_many :answers
    should validate_presence_of :title
    should validate_presence_of :field_type
    should allow_value('TextField', 'RadioSelect', 'Checkbox').for(:field_type)
    should_not allow_value('Ipsem').for(:field_type)
  end
end
