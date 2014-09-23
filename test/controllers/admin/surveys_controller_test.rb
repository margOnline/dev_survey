require 'test_helper'

class Admin::SurveysControllerTest < ActionController::TestCase

  context 'with admin' do
    setup do
      @admin = FactoryGirl.create(:user, :admin)
      sign_in(@admin)
      @object = FactoryGirl.create(:survey)
    end

    should 'index: show list of all surveys sorted by user_role' do
      get :index
      assert_response :success
      assert_template :index
    end

    should 'show: display individual survey' do
      get :show, :id => @object.id
      assert_response :success
      assert_template :show
    end

    should 'delete record' do
      assert_difference 'Survey.count', -1 do
        delete :destroy, :id => @object.id
      end
      assert_redirected_to admin_surveys_path
    end
  end

  context 'as a developer user' do
    setup do
      @developer = FactoryGirl.create(:user)
      sign_in(@developer)
      @object = FactoryGirl.create(:survey)
    end

    should 'index: not display' do
      get :index
      assert_redirected_to new_user_session_path
    end

    should 'show: not display' do
      get :show, :id => @object.id
      assert_redirected_to new_user_session_path
    end

    should 'not delete record' do
      assert_no_difference 'Survey.count' do
        delete :destroy, :id => @object.id
      end
      assert_redirected_to new_user_session_path
    end
  end

end
