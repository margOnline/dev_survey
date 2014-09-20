class Survey < ActiveRecord::Base
  belongs_to :user
  has_many :answers,:dependent => :destroy
  has_many :questions, :through => :answers

  accepts_nested_attributes_for :answers

  validates :user, :presence => true
  validate :required_questions_completed

  private

  def required_questions_completed
    if required_questions.count != answers_for_required_questions.count
      errors.add(:user_id, "Please answer all required questions")
    end
  end

  def required_questions
    Question.where(:required => true)
  end

  def answers_for_required_questions
    answers.select do |answer|
      answer.question.present? && answer.question.required?
    end
  end

end
