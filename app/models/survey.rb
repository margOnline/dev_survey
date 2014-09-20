class Survey < ActiveRecord::Base
  belongs_to :user
  has_many :answers,:dependent => :destroy
  has_many :questions, :through => :answers
  validates :user, :presence => true
end
