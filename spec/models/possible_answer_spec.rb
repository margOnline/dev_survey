require 'rails_helper'

describe PossibleAnswer do
  it { should belong_to :question }
  it { should have_many :answers }
  it { should have_many :question_answer_choices }
  it { should validate_presence_of :question }
  it { should validate_presence_of :text }
end