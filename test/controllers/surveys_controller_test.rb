require 'test_helper'

class SurveysControllerTest < ActionController::TestCase
  setup do
    @user = FactoryGirl.create(:user)
  end

  context 'new' do
    @survey = FactoryGirl.build(:survey)
    should 'render the form' do
      get :new, :token => @user.token
      expect(assigns(:teams)).to eq([team])
      assert_assigns :survey, @survey
    end

    context 'set up correct questions' do
      setup do
        @dev_question = FactoryGirl.create(:question, :for_dev)
        @company_question = FactoryGirl.create(:question, :for_company)
        @general_question = FactoryGirl.create(:question, :general)
      end

      should 'for developer' do
        get :new, :token => @user.token
        expect(assigns(:teams)).to eq([team])
        assert_assigns :questions, [@dev_question, @general_question]
      end

      should 'for company' do
        company_user = FactoryGirl.create(:user, :company)
        get :new, :token => company_user.token
        expect(assigns(:teams)).to eq([team])
        assert_assigns :questions, [@company_question, @general_question]
      end
    end
  end

  context 'create' do    
    setup do
      @required_question = FactoryGirl.create(:question, :required)
      @unrequired_question = FactoryGirl.create(:question)
    end

    should 'save survey with required and unrequired questions' do
      assert_difference 'Survey.count' do
        assert_difference 'Answer.count', 2 do
          post :create,
            :survey => {
              :answers_attributes => {
                "0" => {
                  :question_id => @required_question.id, :text => 'required'
                  },
                "1" => {
                  :question_id => @unrequired_question.id, :text => 'not required'
                  }
                },
              :user_id => @user.id
            }
        end
      end
      assert_response :redirect
      assert_redirected_to thanks_path
    end

    should 'save survey with only required questions' do
      assert_difference 'Survey.count' do
        assert_difference 'Answer.count', 1 do
          post :create,
            :survey => {
              :answers_attributes => {
                "0" => {
                  :question_id => @required_question.id, :text => 'ipsem lorem'
                }
              },
              :user_id => @user.id
            }
        end
      end
      assert_response :redirect
      assert_redirected_to thanks_path
    end

    context 'with radio buttons & checkboxes' do
      setup do
        @checkbox = FactoryGirl.create(:question, :required, :field_type => 'Checkbox')
        @checkbox.possible_answers.create(:text => 'option 1')
        @checkbox.possible_answers.create(:text => 'option 2')
        @radio_button = FactoryGirl.create(:question, :required, :field_type => 'RadioSelect')
        @radio_button.possible_answers.create(:text => 'option 1')
        @radio_button.possible_answers.create(:text => 'option 2')
      end

      should 'save survey successfully with all required fields' do
        assert_difference 'Survey.count' do
          assert_difference 'Answer.count', 3 do
            assert_difference 'QuestionAnswerChoice.count', 3 do
              post :create,
                :survey => {
                  :user_id => @user.id,
                  :answers_attributes => {
                  "0" => {
                    :question_id => @required_question.id, :text => 'ipsem lorem'
                  },
                  "1" => {
                      :question_id => @checkbox.id, :question_answer_choices_attributes => [
                        {:possible_answer_id => @checkbox.possible_answers[0].id},
                        {:possible_answer_id =>  @checkbox.possible_answers[1].id}
                      ]
                    },
                  "2" => {
                      :question_id => @radio_button.id, :question_answer_choices_attributes => [
                        {:possible_answer_id => @radio_button.possible_answers[0].id}
                      ]
                    }
                  }
                }
            end
          end
        end

        assert_response :redirect
        assert_redirected_to thanks_path
      end

      should 'not save survey with missing checkbox' do
        assert_no_difference 'Survey.count' do
          assert_no_difference 'Answer.count' do
            assert_no_difference 'QuestionAnswerChoice.count'do
              post :create,
                :survey => { :user_id => @user.id, :answers_attributes => {
                "0" => {
                  :question_id => @required_question.id, :text => 'ipsem lorem'
                },
                "1" => {
                    :question_id => @radio_button.id, :question_answer_choices_attributes => [
                      {:possible_answer_id => @radio_button.possible_answers[0].id}
                    ]
                  }
                }
              }
            end
          end
        end

        assert_response :success
        assert_template :new
      end

      should 'not save survey with missing radio button' do
        assert_no_difference 'Survey.count' do
          assert_no_difference 'Answer.count' do
            assert_no_difference 'QuestionAnswerChoice.count'do
              post :create,
                :survey => { :user_id => @user.id, :answers_attributes => {
                  "0" => {
                    :question_id => @required_question.id, :text => 'ipsem lorem'
                  },
                  "1" => {
                      :question_id => @checkbox.id, :question_answer_choices_attributes => [
                        {:possible_answer_id => @checkbox.possible_answers[0].id},
                        {:possible_answer_id =>  @checkbox.possible_answers[1].id}
                      ]
                    },
                  }
                }
            end
          end
        end

        assert_response :success
        assert_template :new
      end
    end

    should 'render new form on submission with errors' do
      assert_no_difference 'Survey.count' do
        assert_no_difference 'Answer.count' do
          post :create,
            :survey => { :user_id => @user.id, :answers_attributes => {
              "0" => {
                :question_id => @required_question.id, :text => ''
              }
            }
          }
        end
      end
      assert_response :success
      assert_template :new
    end
  end
end
