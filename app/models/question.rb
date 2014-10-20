class Question < ActiveRecord::Base
  QUESTION_TYPES = %w(TextField Checkbox RadioSelect Textarea)

  ## Associations
  has_many :answers
  has_many :possible_answers, :dependent => :destroy
  belongs_to :question_group

  ## Validations
  validates :title, :presence => true
  validates :field_type,
      :presence => true, :inclusion => { :in => QUESTION_TYPES }

  ## Class Methods ##
  def self.for_developer
    joins(:question_group).merge(QuestionGroup.developer)
  end

  def self.for_company
    joins(:question_group).merge(QuestionGroup.company)
  end

  def self.general
    joins(:question_group).merge(QuestionGroup.general)
  end

end
