class Survey < ActiveRecord::Base
  after_save :send_survey_completed, :only => :create

  belongs_to :user
  has_many :answers,:dependent => :destroy
  has_many :questions, :through => :answers

  accepts_nested_attributes_for :answers

  validates :user, :presence => true
  validate :required_questions_completed

  private

  def required_questions_completed
    @required_questions = user.dev? ? required_dev_questions : required_company_questions
      if @required_questions.count != answers_for_required_questions.count
        errors.add(:user_id, "Please answer all required questions")
      end
  end

  def required_dev_questions
    Question.required_for_dev
  end

  def required_company_questions
    Question.required_for_company
  end

  def answers_for_required_questions
    answers.select do |answer|
      answer.question.present? && answer.question.required?
    end
  end

  def send_survey_completed
    AdminMailer.notify_admin(self.id).deliver
  end

end
