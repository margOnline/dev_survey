require 'rails_helper'

describe QuestionAnswerChoice do
  it { should belong_to :answer }
  it { should belong_to :possible_answer }
  it {should validate_presence_of :possible_answer }
end
