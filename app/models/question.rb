class Question < ActiveRecord::Base
  QUESTION_TYPES = %w(TextField Checkbox RadioSelect Textarea)

  ## Associations
  has_many :answers
  has_many :possible_answers, :dependent => :destroy
  belongs_to :question_group

  ## Validations
  validates :question_group, :presence => true
  validates :title, :presence => true
  validates :position, :uniqueness => true, numericality: { only_integer: true }
  validates :field_type,
      :presence => true, :inclusion => { :in => QUESTION_TYPES }

  ## Class Methods ##
  def self.by_position
    order(position: :asc)
  end

  def self.for_dev
    joins(:question_group).merge(QuestionGroup.dev).by_position
  end

  def self.for_company
    joins(:question_group).merge(QuestionGroup.company).by_position
  end

  def self.general
    joins(:question_group).merge(QuestionGroup.general).by_position
  end

  def self.required_for_dev
    (required.for_dev + required.general)
  end

  def self.required_for_company
    (required.for_company + required.general)
  end

  ## Scopes ##
  scope :required, -> { where(:required => true ) }
  scope :required_general, -> { required.general }

  def answers_by_possible_answer
    Hash[possible_answers.map {|pa| [pa, pa.answers.count]}]
  end
end
