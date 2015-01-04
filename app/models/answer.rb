class Answer < ActiveRecord::Base
  belongs_to :survey
  belongs_to :question
  has_many :question_answer_choices, :inverse_of => :answer, :dependent => :destroy
  has_many :possible_answers, :through => :question_answer_choices

  accepts_nested_attributes_for :question_answer_choices

  validates :question, :presence => true
  validate :required_question_answered

  private

  def required_question_answered
    if question && question.required?
      case question.field_type
      when "TextField"
        errors.add(:text, "This question is required") unless text.present?
      else
        errors.add(:text, "This question is required") unless question_answer_choices.any?
      end
    end
  end
end
