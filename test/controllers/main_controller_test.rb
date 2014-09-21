require 'test_helper'

class MainControllerTest < ActionController::TestCase
  should 'get index' do
    get :index
    assert_response :success
  end

  should 'get thanks' do
    get :index
    assert_response :success
  end

end
