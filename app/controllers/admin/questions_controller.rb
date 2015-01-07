class Admin::QuestionsController <ApplicationController
  before_action :validate_rights, :only => [:index, :show, :destroy]

  def index
    @questions = Question.paginate(:page => params[:page])
  end

  def show
    @question = Question.find(params[:id])
  end

  private

  def validate_rights
    redirect_to root_path unless params[:token] && params[:token] == ENV['ADMIN_SECRET_KEY']
  end

end