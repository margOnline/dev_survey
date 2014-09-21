class Question < ActiveRecord::Base
  QUESTION_TYPES = %w(TextField Checkbox RadioSelect)

  ## Associations
  has_many :answers
  has_many :possible_answers, :dependent => :destroy
  belongs_to :question_group

  ## Validations
  validates :title, :presence => true
  validates :field_type,
      :presence => true, :inclusion => { :in => QUESTION_TYPES }
end
