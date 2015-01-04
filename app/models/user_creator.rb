require 'csv'

class UserCreator

  def initialize(args)
    @filename = args[:filename]
  end

  def create!
   csv_text = File.read("#{Rails.root}/tmp/#{@filename}")
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      User.create!(row.to_hash)
    end
  end


end
