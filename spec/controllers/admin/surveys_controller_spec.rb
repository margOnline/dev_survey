require 'rails_helper'

describe Admin::SurveysController do

  describe "with admin" do
    before do
      @object = FactoryGirl.create(:survey)
      @token = ENV['ADMIN_SECRET_KEY']
    end

    it "index: show list of all surveys sorted by user_role" do
      get :index, :token => @token
      expect(response).to render_template(:index)
    end

    it "show: display individual survey" do
      get :show, id: @object.id, :token => @token
      expect(response).to render_template(:show)
    end

    it "delete record" do
      expect {delete :destroy, id: @object.id, token: @token}.to change(Survey, :count).by(-1)
      expect(response).to redirect_to admin_surveys_path
    end
  end

  describe "without token" do
    before do
      @object = FactoryGirl.create(:survey)
    end

    it "index: redirect" do
      get :index
      expect(response).to redirect_to root_path
    end

    it "show: redirect" do
      get :show, id: @object.id
      expect(response).to redirect_to root_path
    end

    it "not delete record" do
      expect{delete :destroy, 
        id: @object.id}.to change(Survey, :count).by(0)
      expect(response).to redirect_to root_path
    end
  end

  describe "with incorrect token" do
    before do
      @object = FactoryGirl.create(:survey)
    end

    it "index: redirect" do
      get :index, :token => 'admin'
      expect(response).to redirect_to root_path
    end

    it "show: redirect" do
      get :show, id: @object.id, :token => 'admin'
      expect(response).to redirect_to root_path
    end

    it "not delete record" do
      expect{delete :destroy, 
        id: @object.id, :token => 'admin'}.to change(Survey, :count).by(0)
      expect(response).to redirect_to root_path
    end
  end

end