DevSurvey::Application.routes.draw do

  root :to => "main#index"
  get '/thanks', :to => 'main#thanks'

  ### Users

  resources :users do
    resources :surveys, :only => [:show]
  end

  resources :surveys, :only => [:new, :create]

  namespace :admin do
    resources :surveys
  end
end
