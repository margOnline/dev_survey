require 'csv'

class UserCreator

  def initialize(args)
    @filename = args[:filename]
  end

  def create!
    CSV.new(@filename, headers: :first_row).each do |row|
      User.create(row.to_hash)
    end
  end


end
