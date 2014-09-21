# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = User.create(
  :email => 'user@example.com',
  :password => 'password',
  :password_confirmation => 'password'
)

questions = [
  { :title => "What are your current goals", :field_type => "TextField",
      :explanation => 'Looking to lose fat, gain muscle, improve strength?',
      :required => true },
  { :title => "What experience do you have", :field_type => "TextField",
      :explanation => "Brief summary of your fitness / workout experience,
      where you're currently at in terms of strength (include current weights
      if applicable).",:required => true },
  { :title => "How many times a week can you train", :field_type => "RadioSelect",
      :explanation => '',:required => true, :options => %w(2 3 4 5+) },
  { :title => "What training facilities do you have access to",
      :field_type => "TextField", :explanation => 'Do you have a gym? If so,
      what sort of equipment is available? If not, do you have anything at home
      or elsewhere?',:required => true },
  { :title => "Do you have any health issues we should be aware of",
      :field_type => "TextField",:explanation => '',:required => true }
]

questions.each do |question|
  options = question.delete(:options)
  q = Question.find_or_create_by(question)
  next if options.nil?
  options.each do |option|
    PossibleAnswer.create(:question => q, :text => option)
  end
end
