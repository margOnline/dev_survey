class PossibleAnswer < ActiveRecord::Base
  belongs_to :question

  validates :question, :presence => true
  validates :text, :presence => true
end
