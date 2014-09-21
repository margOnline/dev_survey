module ApplicationHelper
  def show_required(question)
    question.required? ? " *" : ""
  end
end
