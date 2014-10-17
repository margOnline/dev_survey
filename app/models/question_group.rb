class QuestionGroup < ActiveRecord::Base
  has_many :questions
  validates :name, :presence => true, :uniqueness => true

  scope :dev, -> { where(:name => 'dev') }
  scope :company, -> { where(:name => 'company') }
end
