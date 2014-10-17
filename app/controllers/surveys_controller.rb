class SurveysController < ApplicationController
  before_action :assign_user, :only => [:new]

  def new
    redirect_to root_path if !params[:token]
    @user = User.where(:token => params[:token]).first
    redirect_to user_survey_path(@user, @user.survey.id) if @user.survey_completed?
    @survey = @user.build_survey
    @user.dev? : setup_dev_questions : setup_company_questions
    @questions.each { @survey.answers.build }
  end

  def create
    @user = User.find(params[:survey][:user_id])
    @survey = @user.build_survey(survey_params)
    if @survey.save
      flash[:notice] = 'Thanks for completing the survey'
      redirect_to thanks_path
    else
      setup_questions
      flash[:error] = 'Please amend the errors indicated below.'
      render :new
    end
  end

  def show
    @survey = Survey.find(params[:id])
  end

  private

  def survey_params
    params.require(:survey).permit(
      :answers_attributes => [:id, :question_id, :text,
      :question_answer_choices_attributes => [:possible_answer_id]]
    )
  end

  def setup_dev_questions
    @questions = Question.all
  end

    def setup_company_questions
    @questions = Question.all
  end

end
