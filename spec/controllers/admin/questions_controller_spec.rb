require 'rails_helper'

describe Admin::QuestionsController do

  describe "with admin" do
    before do
      @object = FactoryGirl.create(:question)
      @token = ENV['ADMIN_SECRET_KEY']
    end

    it "index: show list of all questions sorted by user_role" do
      get :index, :token => @token
      expect(response).to render_template(:index)
    end

    it "show: display individual question" do
      get :show, id: @object.id, :token => @token
      expect(response).to render_template(:show)
    end

    context "#create" do
      before { @question_group = FactoryGirl.create(:question_group) }

      it "sucessfully: creates new question and redirects to show all questions" do
        expect { post :create, token: @token,
          question: { 
            title: 'whatever', explanation: 'introduction', 
            required: true, position: 1, question_group_id: 
            @question_group.id, field_type: 'TextField' 
          }
        }.to change(Question, :count).by(1)
        expect(response).to redirect_to admin_questions_path
      end
      it "with errors: creates new question and redirects to show all questions" do
        expect { post :create, token: @token,
          question: { title: 'whatever', explanation: 'introduction', 
            required: true, position: 1, question_group_id: @question_group.id }
        }.to change(Question, :count).by(0)
        expect(response).to render_template(:new)
      end
    end
    context "#update" do
      before do 
        @question = FactoryGirl.create(:question, position: 1 )
      end

      it "sucessfully: updates a question and redirects to show all questions" do
        post :update, token: @token, id: @object.id, question: { position: 2 }
        expect(@object.reload.position).to eq 2
        expect(response).to redirect_to admin_questions_path
      end
      it "with errors: does not update question and redirects to show all questions" do
        post :update, token: @token, id: @object.id, question: { position: 2, title: nil }
        expect(@object.reload.position).to eq 1
        expect(response).to redirect_to admin_questions_path
      end
    end
  end

  describe "without token" do
    before do
      @object = FactoryGirl.create(:question)
      @question_group = FactoryGirl.create(:question_group)
    end

    it "index: redirect" do
      get :index
      expect(response).to redirect_to root_path
    end
    it "show: redirect" do
      get :show, id: @object.id
      expect(response).to redirect_to root_path
    end
    it "create: redirect" do
      post :create, 
        question: { 
          title: 'whatever', explanation: 'introduction', 
          required: true, position: 1, question_group_id: 
          @question_group.id, field_type: 'TextField' 
        }
      expect(response).to redirect_to root_path
    end
    it "update: redirect" do
      post :update, id: @object.id,
        question: { 
          title: 'whatever', explanation: 'introduction', 
          required: true, position: 1, question_group_id: 
          @question_group.id, field_type: 'TextField' 
        }
      expect(response).to redirect_to root_path
    end
  end

  describe "with incorrect token" do
    before do
      @object = FactoryGirl.create(:question)
      @question_group = FactoryGirl.create(:question_group)
    end

    it "index: redirect" do
      get :index, :token => 'admin'
      expect(response).to redirect_to root_path
    end
    it "show: redirect" do
      get :show, id: @object.id, :token => 'admin'
      expect(response).to redirect_to root_path
    end
    it "create: redirect" do
      post :create,
        question: { 
          title: 'whatever', explanation: 'introduction', 
          required: true, position: 1, question_group_id: 
          @question_group.id, field_type: 'TextField' 
        }
      expect(response).to redirect_to root_path
    end

  end

end