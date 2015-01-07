class PossibleAnswer < ActiveRecord::Base
  belongs_to :question
  has_many :question_answer_choices
  has_many :answers, through: :question_answer_choices

  validates :question, :presence => true
  validates :text, :presence => true
end
