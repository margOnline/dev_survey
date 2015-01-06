module SurveysHelper
  def show_explanation_for(question)
    html = "<p class='explain'>#{question.explanation}</p>"
    html.html_safe
  end

  def admin_time_string(time)
    format = '%a, %d %b <em class="meta">%H:%M UTC</em>'
    time.strftime(format)
  end

  def answers_for_radio_select(answers)
    if answers.first.question_answer_choices.any?
      answers.first.question_answer_choices.first.possible_answer.text
    end
  end

  def answers_for_checkbox(answers)
    html = "<ul class='profile_answers'>"
      answers.first.question_answer_choices.each do |sa|
        html << content_tag(:li, sa.possible_answer.text)
      end
      html << "</ul>"
      html.html_safe
  end

  def answers_for_textarea(answers)
    answers.first.text
  end
end
