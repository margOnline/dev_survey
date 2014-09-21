class SurveyPresenter < Exhibit::Presenter

  exhibit :initial_assessment
  attr_reader :questions, :form

  delegate :answers, :to => :initial_assessment

  def initialize(object, template)
    super
  end

  def display_form(form, questions)
    @questions = questions
    @form = form
    fieldset_block + display_submit
  end

  private

  def fieldset_block
    content_tag(:fieldset) do
      content_tag(:ol) do
         form_fields
      end
    end
  end

  def form_fields
    output = "".html_safe
    @questions.each_with_index do |question, index|
      output << question_input(question, index)
    end
    return output
  end

  def question_input(question, index)
    answer = get_answer_for_question(question)
    render :partial => question.field_type.underscore,
      :locals => {:question => question, :answer => answer, :index => index}
  end

  def display_submit
    content_tag(:div, :class => "submit") do
      button_tag 'Submit', :class => 'btn'
    end
  end

  def get_answer_for_question(q)
    answers.find{|a| a.question_id == q.id} || initial_assessment.answers.build
  end

end
