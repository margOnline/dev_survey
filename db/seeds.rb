# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


company = QuestionGroup.create(:name => 'company')
dev = QuestionGroup.create(:name => 'developer')
general = QuestionGroup.create(:name => 'general')

questions = [
  { :title => "How long have you been with the company?", :field_type => "RadioSelect",
    :options => ["less than 3 months", "3-6 months", "6-12 months", "more than a year"],
    :required => true, :question_group_id => dev.id, :position => 1 },
  { :title => "Does the company have a programme in place to support Junior Developers?",
    :field_type => "RadioSelect", :options => %w(yes no),:required => true,
    :question_group_id => general.id, :position => 2},
  { :title => "Do you work in a team with other developers using the same technology", :field_type => "RadioSelect",
    :options => %w(yes no),:required => true,
    :question_group_id => dev.id, :position => 4},
  { :title => "How often do you pair programme?", :field_type => "RadioSelect",
    :options => ["Always", "Frequently", "Occasionally", "Rarely", "Never"],:required => true,
    :question_group_id => dev.id, :position => 5},
  { :title => "Is it easy to get help?", :field_type => "RadioSelect",
    :options => %w(yes no),:required => true,
    :question_group_id => dev.id, :position => 7},
  { :title => "Does the company assign mentors to junior developers", :field_type => "RadioSelect",
    :options => %w(yes no),:required => true,
    :question_group_id => company.id, :position => 6},
  { :title => "How often do you receive feedback?", :field_type => "RadioSelect",
    :options => ["monthly", "Annually", "Ad Hoc"],
    :question_group_id => dev.id, :position => 8},
  { :title => "In what area have you most improved?", :explanation => 'e.g. testing, debugging, data modelling, javascript',
    :field_type => "TextField",
    :question_group_id => dev.id, :position => 9},
  { :title => "If you could change one thing about your first year, what would it be?",
    :field_type => "Textarea",
    :question_group_id => dev.id, :position => 10},

  { :title => "In your opinion, does the company have a learning culture?", :field_type => "RadioSelect",
    :options => %w(yes no), :explanation => 'e.g. a conference policy, a policy for attending courses or buying books',
    :required => true, :question_group_id => dev.id, :position => 3 },
  { :title => "Would you be willing to be contacted to provide more information?", :field_type => "RadioSelect",
    :options => ["Yes", "No"],
    :question_group_id => general.id, :position => 12},
  { :title => "Do you wish to receive the survey results?", :field_type => "RadioSelect",
    :options => ["Yes", "No"],
    :question_group_id => general.id, :position => 13},
  { :title => "Feel free to add any comments, suggestions", :field_type => "Textarea",
    :question_group_id => general.id, :position => 11}

  # { :title => "Do you have a computer science degree?", :field_type => "RadioSelect",
  #   :options => %w(yes no),:required => true,
  #   :question_group_id => dev.id},
  # { :title => "What was your previous experience in Tech?", :field_type => "Checkbox",
  #   :options => ["Developer", "Quality Assurance / Testing ", "Designer", "None",  "Other"],
  #   :required => true,
  #   :question_group_id => dev.id},
]

questions.each do |question|
  options = question.delete(:options)
  q = Question.find_or_create_by(question)
  next if options.nil?
  options.each do |option|
    PossibleAnswer.create(:question => q, :text => option)
  end
end
