class Token < ActiveRecord::Base

  validates :code, :uniqueness => true
  validate :code_has_correct_prefix

  def code_has_correct_prefix
    if Token.prefix.select { |p| code.start_with?(p) }.none?
      errors.add(:base, "invalid prefix")
    end
  end

  def self.prefix
    %w(Co Dev)
  end
end
