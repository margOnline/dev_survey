class QuestionAnswerChoice < ActiveRecord::Base
  belongs_to :answer
  belongs_to :possible_answer

  validates :possible_answer, :presence => true
  validates :answer, :presence => true
end
