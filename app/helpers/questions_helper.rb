module QuestionsHelper
  def question_groups_dropdown(form)
    form.select(
      :question_group_id,
      QuestionGroup.all.map { |qg| [qg.name, qg.id] },
      { prompt: 'Select one' }
    )
  end

end