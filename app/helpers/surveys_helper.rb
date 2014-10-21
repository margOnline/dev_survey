module SurveysHelper
  def show_explanation_for(question)
    html = "<p class='explain'>#{question.explanation}</p>"
    html.html_safe
  end

  def admin_time_string(time)
    format = '%a, %d %b <em class="meta">%H:%M UTC</em>'
    time.strftime(format)
  end
end
