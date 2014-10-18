namespace :dev_survey do
  namespace :tokens do
    desc "generate tokens in bulk"
    task :generate => :environment
    task :generate, [:prefix, :number] do |t, args|
      abort invalid_tokens_args_message unless args.prefix && args.number
      abort invalid_prefix_message unless Token.prefix.include? args.prefix
      abort invalid_number_message unless args.number.to_i > 0
      TokenCodeGenerator.new(args).generate_token_codes
    end
  end

  namespace :users do
    desc "create users in bulk from csv"
    task :create => :environment
    task :create, [:filename] do |t, args|
      abort invalid_users_args_message unless args.filename
      abort invalid_file_message unless correct_file_type?(args.filename)
      UserCreator.new(args).create!
    end
  end
end

private

def invalid_tokens_args_message
  "Usage: rake dev_survey:tokens:generate[prefix, number]"
end

def invalid_prefix_message
  "prefix must be one of 'Dev', 'Co"
end

def invalid_number_message
  "number must be an integer greater than zero"
end

def correct_file_type?(filename)
  filename[-4,4] == '.csv'
end

def invalid_users_args_message
  "Usage: rake dev_survey:users:create[filename]"
end

def invalid_file_message
  "A csv file is required."
end
