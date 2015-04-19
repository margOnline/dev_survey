require 'rails_helper'

describe SurveysController do
  before do
    @user = FactoryGirl.create(:user)
  end

  describe "new" do
    @survey = FactoryGirl.build_stubbed(:survey)
    it "renders the form" do
      get :new, :token => @user.token
      expect(assigns(:survey))
    end

    describe "set up correct questions" do
      before do
        @dev_question = FactoryGirl.create(:question, :for_dev)
        @company_question = FactoryGirl.create(:question, :for_company)
        @general_question = FactoryGirl.create(:question, :general)
      end

      it "for developer" do
        get :new, token: @user.token
        expect(assigns(:questions)).to eq [@dev_question, @general_question]
      end

      it "for company" do
        company_user = FactoryGirl.create(:user, :company)
        get :new, token: company_user.token
        expect(assigns(:questions)).to eq [@company_question, @general_question]
      end
    end
  end

  describe "create" do    
    before do
      @required_question = FactoryGirl.create(:question, :required)
      @unrequired_question = FactoryGirl.create(:question)
    end

    it "saves survey with required and unrequired questions" do
      expect { post :create,
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
      }.to change(Answer, :count).by(2)
      expect(response).to redirect_to thanks_path
    end

    it "saves survey with only required questions" do
      expect {post :create,
        :survey => {
          :answers_attributes => {
            "0" => {
              :question_id => @required_question.id, :text => 'ipsem lorem'
            }
          },
          :user_id => @user.id
        }
      }.to change(Answer, :count).by(1)
      expect(response).to redirect_to thanks_path
    end

    describe "with radio buttons & checkboxes" do
      before do
        @checkbox = FactoryGirl.create(:question, :required, :field_type => 'Checkbox')
        @checkbox.possible_answers.create(:text => 'option 1')
        @checkbox.possible_answers.create(:text => 'option 2')
        @radio_button = FactoryGirl.create(:question, :required, :field_type => 'RadioSelect')
        @radio_button.possible_answers.create(:text => 'option 1')
        @radio_button.possible_answers.create(:text => 'option 2')
      end

      it "saves QuestionAnswerChoice successfully" do
        expect {post :create,
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
          }.to change(QuestionAnswerChoice, :count).by(3)
        expect(response).to redirect_to thanks_path
      end

      it "does not save survey with missing checkbox" do
        expect { post :create,
          :survey => { :user_id => @user.id, :answers_attributes => {
          "0" => {
            :question_id => @required_question.id, :text => 'ipsem lorem'
          },
          "1" => {
              :question_id => @radio_button.id, question_answer_choices_attributes: 
                [{:possible_answer_id => @radio_button.possible_answers[0].id} ]
              }
            }
          }
        }.to change(Answer, :count).by(0)
        expect(response).to render_template(:new)
      end

      it "does not save survey with missing radio button" do
        expect {post :create,
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
        }.to change(QuestionAnswerChoice, :count).by(0)
        expect(response).to render_template(:new)
      end
    end

    it "renders new form on submission with errors" do
      expect {post :create,
        :survey => { :user_id => @user.id, answers_attributes: {
          "0" => {
            :question_id => @required_question.id, :text => ''
            }
          }
        }
      }.to change(Survey, :count).by(0)
      expect(response).to render_template(:new)
    end
  end
end