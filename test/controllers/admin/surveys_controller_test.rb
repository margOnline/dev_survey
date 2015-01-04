require 'test_helper'

class Admin::SurveysControllerTest < ActionController::TestCase

  context 'with admin' do
    setup do
      @object = FactoryGirl.create(:survey)
      @token = ENV['ADMIN_SECRET_KEY']
    end

    should 'index: show list of all surveys sorted by user_role' do
      get :index, :token => @token
      assert_response :success
      assert_template :index
    end

    should 'show: display individual survey' do
      get :show, :id => @object.id, :token => @token
      assert_response :success
      assert_template :show
    end

    should 'delete record' do
      assert_difference 'Survey.count', -1 do
        delete :destroy, :id => @object.id, :token => @token
      end
      assert_redirected_to admin_surveys_path
    end
  end

  context 'without token' do
    setup do
      @object = FactoryGirl.create(:survey)
    end

    should 'index: redirect' do
      get :index
      assert_redirected_to root_path
    end

    should 'show: redirect' do
      get :show, :id => @object.id
      assert_redirected_to root_path
    end

    should 'not delete record' do
      assert_no_difference 'Survey.count' do
        delete :destroy, :id => @object.id
      end
      assert_redirected_to root_path
    end
  end

  context 'with incorrect token' do
    setup do
      @object = FactoryGirl.create(:survey)
    end

    should 'index: redirect' do
      get :index, :token => 'admin'
      assert_redirected_to root_path
    end

    should 'show: redirect' do
      get :show, :id => @object.id, :token => 'admin'
      assert_redirected_to root_path
    end

    should 'not delete record' do
      assert_no_difference 'Survey.count' do
        delete :destroy, :id => @object.id, :token => 'admin'
      end
      assert_redirected_to root_path
    end
  end

end
