module SurveysHelper
  def show_explanation_for(question)
    html = "<p>#{question.explanation}</p>"
    html.html_safe
  end
end
