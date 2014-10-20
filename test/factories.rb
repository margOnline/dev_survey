include ActionDispatch::TestProcess
require 'factory_girl'


#############################
###         USERS         ###
#############################

FactoryGirl.define do
  sequence(:username) { |n| "user-#{n}" }
  sequence(:token_code) {[*(1..9), *('A'..'Z')].flatten.sample(10).join}

  factory :user, :class => User do
    email         { |u| "#{FactoryGirl.generate(:username)}@example.com" }
    token         { |u| "Dev#{FactoryGirl.generate(:token_code)}"}

    trait :company do
      token       { |u| "Co#{FactoryGirl.generate(:token_code)}"}
    end

    trait :with_auth_token do
      auth_token { |u| "auth-token-#{u.email}"}
    end

    trait :admin do
      role        'Admin'
    end

    trait :with_survey do
      association :survey
    end

  end

  #############################
  ###    EVERYTHING ELSE    ###
  ### ALPHABETIZE THIS LIST ###
  #############################

  factory :answer do |f|
    association :survey
    association :question
  end

  factory :possible_answer do |f|
    text 'Hello'
    question
  end

  factory :question do |f|
    title 'What colour is the sky?'
    field_type 'TextField'

    trait :required do
      required true
    end

    trait :for_developer do
      association :question_group
    end

    trait :for_company do
      association :question_group, :company
    end

    trait :general do
      association :question_group, :general
    end
  end

  factory :question_group do
    name 'developer'

    trait :company do
      name 'company'
    end

    trait :general do
      name 'general'
    end
  end

  factory :survey do |f|
    association :user
  end

  factory :token do |f|
    code   { |c| "Co#{FactoryGirl.generate(:token_code)}" }
  end

end
