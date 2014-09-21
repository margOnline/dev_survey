class SurveysController < ApplicationController
  before_action :authenticate_user!

  def new
    return if current_user.survey
    @survey = current_user.build_survey
    setup_questions
    @questions.each { @survey.answers.build }
  end

  def create
    @survey = current_user.build_survey(survey_params)
    if @survey.save
      flash[:notice] = 'Thanks for completing the survey'
      redirect_to thanks_path
    else
      setup_questions
      flash[:error] = 'Please amend the errors indicated below.'
      render :new
    end
  end

  private

  def survey_params
    params.require(:survey).permit(
      :answers_attributes => [:id, :question_id, :text,
      :question_answer_choices_attributes => [:possible_answer_id]]
    )
  end

  def setup_questions
    @questions = Question.all
  end
end
