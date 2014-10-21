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
    :options => ["less than 1 year", "1-5 years"],
    :required => true, :question_group_id => dev.id },
  { :title => "Do you have a computer science degree?", :field_type => "RadioSelect",
    :options => %w(yes no),:required => true,
    :question_group_id => dev.id},
  { :title => "Does the company have a learning culture?", :field_type => "RadioSelect",
    :options => %w(yes no), :explanation => 'e.g. a conference policy, a policy for attending courses or buying books',
    :required => true, :question_group_id => dev.id },
  { :title => "Do you have a mentor", :field_type => "RadioSelect",
    :options => %w(yes no),:required => true,
    :question_group_id => dev.id},
  { :title => "What was your previous experience in Tech?", :field_type => "Checkbox",
    :options => ["Developer", "Quality Assurance / Testing ", "Designer", "None",  "Other"],
    :required => true,
    :question_group_id => dev.id},
  { :title => "Does your company have a programme in place to support Junior Developers?",
    :field_type => "RadioSelect",
    :options => %w(yes no),:required => true,
    :question_group_id => general.id},
  { :title => "Do you wish to receive the survey results?", :field_type => "Checkbox",
    :options => ["Yes", "No"],
    :question_group_id => general.id},
  { :title => "How often do you receive feedback?", :field_type => "RadioSelect",
    :options => ["monthly", "Annually", "Ad Hoc"],
    :question_group_id => dev.id},
  { :title => "How often do you pair programme?", :field_type => "RadioSelect",
    :options => ["Always", "Frequently", "Occasionally", "Rarely", "Never"],
    :question_group_id => dev.id},
  { :title => "In what area have you most improved?", :explanation => 'e.g. testing, debugging, data modelling, javascript',
    :field_type => "TextField",
    :question_group_id => dev.id},
  { :title => "If you could change one thing about the last 3-6 months, what would it be?",
    :field_type => "Textarea",
    :question_group_id => dev.id},
  { :title => "How often do you pair programme", :field_type => "RadioSelect",
    :options => ["Always", "Frequently", "Occasionally", "Rarely", "Never"],
    :question_group_id => dev.id},
  { :title => "Feel free to add any comments, suggestions", :field_type => "Textarea",
    :question_group_id => general.id}
]

questions.each do |question|
  options = question.delete(:options)
  q = Question.find_or_create_by(question)
  next if options.nil?
  options.each do |option|
    PossibleAnswer.create(:question => q, :text => option)
  end
end
