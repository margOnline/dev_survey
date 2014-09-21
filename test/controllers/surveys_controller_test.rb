require 'test_helper'

class SurveysControllerTest < ActionController::TestCase
  setup do
    @user = FactoryGirl.create(:user)
    sign_in(@user)
  end

  context 'new' do
    @survey = FactoryGirl.build(:survey, :user => @user)
    should 'render the form' do
      get :new, :user_id => @user.id
      assert_assigns :survey, @survey
    end
  end

  context 'create' do
    context 'create' do
      setup do
        @required_question = FactoryGirl.create(:question, :required)
        @unrequired_question = FactoryGirl.create(:question)
      end

      should 'save survey with required and unrequired questions' do
        assert_difference 'Survey.count' do
          assert_difference 'Answer.count', 2 do
            post :create, :user_id => @user.id,
              :survey => { :answers_attributes => {
                "0" => {
                  :question_id => @required_question.id, :text => 'required'
                  },
                "1" => {
                  :question_id => @unrequired_question.id, :text => 'not required'
                  }
                }
              }
          end
        end
        assert_response :redirect
        assert_redirected_to thanks_path
      end

      should 'save survey with only required questions' do
        assert_difference 'Survey.count' do
          assert_difference 'Answer.count', 1 do
            post :create, :user_id => @user.id,
              :survey => { :answers_attributes => {
                "0" => {
                  :question_id => @required_question.id, :text => 'ipsem lorem'
                }
              }
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
                post :create, :user_id => @user.id,
                  :survey => { :answers_attributes => {
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
                post :create, :user_id => @user.id,
                  :survey => { :answers_attributes => {
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
                post :create, :user_id => @user.id,
                  :survey => { :answers_attributes => {
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
            post :create, :user_id => @user.id,
              :survey => {:answers_attributes => {
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
end