class Admin::QuestionsController <ApplicationController
  before_action :validate_rights
  before_action :setup_question, only: [:show, :edit, :update, :archive]

  def index
    @questions = Question.paginate(:page => params[:page])
  end

  def show
    
  end
  
  def new
    @question = Question.new
  end
  
  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to admin_questions_path
    else
      render :new
    end
  end

  def edit
    
  end
  
  def update
    if @question.update(question_params)
      redirect_to admin_questions_path
    else
      render :edit
    end
  end
  
  def archive
    @question = Question.find(params[:id])
  end

  private
  def question_params
    params.require(:question).permit(:title, :explanation, :field_type, :question_group_id,
     :required, :position)
  end

  def validate_rights
    redirect_to root_path unless params[:token] && params[:token] == ENV['ADMIN_SECRET_KEY']
  end

  def setup_question
    @question = Question.find(params[:id])
  end

end