class Admin::SurveysController <ApplicationController
  before_action :validate_rights

  def index
    @surveys = Survey.paginate(:page => params[:page])
  end

  def show
    @survey = Survey.find(params[:id])
  end

  def destroy
    @survey = Survey.destroy(params[:id])
    redirect_to admin_surveys_path
  end

  private

  def validate_rights
    redirect_to root_path unless params[:token] && params[:token] == ENV['ADMIN_SECRET_KEY']
  end

end
