class SurveysController < ApplicationController
  before_action :validate_rights, :only => [:new]

  def new
    @user = User.where(:token => params[:token]).first
    redirect_to root_path(@user, @user.survey.id) if @user.survey_completed?
    @survey = @user.build_survey
    setup_questions
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

  def setup_questions
     @user.dev? ? setup_dev_questions : setup_company_questions
  end

  private

  def survey_params
    params.require(:survey).permit(
      :answers_attributes => [:id, :question_id, :text,
      :question_answer_choices_attributes => [:possible_answer_id]]
    )
  end

  def setup_dev_questions
    @questions = (Question.for_dev + Question.general + Question.background).sort_by do |q|
      q.question_group
    end
  end

  def setup_company_questions
    @questions = (Question.for_company + Question.general).sort_by do |q|
      q.question_group
    end
  end

  def validate_rights
    redirect_to root_path if !params[:token]
  end

end
