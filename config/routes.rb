DevSurvey::Application.routes.draw do

  root :to => "main#index"
  get '/thanks', :to => 'main#thanks'

  ### Users
  devise_for :users

  resources :users, :only => :index do
    resources :surveys, :only => [:new, :create]
  end
end
