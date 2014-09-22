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

company = QuestionGroup.new(:name => 'company')
dev = QuestionGroup.new(:name => 'developer')
background = QuestionGroup.new(:name => 'background')

questions = [
  { :title => "How long have you been with the company?", :field_type => "RadioSelect",
    :options => %Q(less\sthan\sa\syear 1-5\syears),
    :required => true, :question_group_id => developer_qs.id },
  { :title => "Do you have a computer science degree?", :field_type => "RadioSelect",
    :options => %w(yes no),:required => true,
    :question_group_id => developer_qs.id},
  { :title => "Does the company have a learning culture?", :field_type => "RadioSelect",
    :options => %w(yes no), :explanation => 'e.g. a conference policy, a policy for attending courses or buying books'
    :required => true, :question_group_id => developer_qs.id },
  { :title => "Do you have a mentor", :field_type => "RadioSelect",
    :options => %w(yes no),:required => true,
    :question_group_id => developer_qs.id},
  { :title => "What was your previous experience in Tech?", :field_type => "Checkbox",
    :options => %Q(Developer Quality\sAssurance\\Tester Designer None Other),:required => true,
    :question_group_id => background.id},
  { :title => "Does your company have a programme in place to support Junior Developers?", :field_type => "RadioSelect",
    :options => %w(yes no),:required => true,
    :question_group_id => developer_qs.id},
] { :title => "Do you have a mentor", :field_type => "RadioSelect",
    :options => %Q(Daily Weekly Monthly Yearly Ad\sHoc),:required => true,
    :question_group_id => developer_qs.id},

questions.each do |question|
  options = question.delete(:options)
  q = Question.find_or_create_by(question)
  next if options.nil?
  options.each do |option|
    PossibleAnswer.create(:question => q, :text => option)
  end
end
