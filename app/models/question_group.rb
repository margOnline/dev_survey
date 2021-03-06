class QuestionGroup < ActiveRecord::Base
  has_many :questions
  validates :name, :presence => true

  scope :dev, -> { where(:name => 'developer') }
  scope :company, -> { where(:name => 'company') }
  scope :general, -> { where(:name => 'general') }
end
