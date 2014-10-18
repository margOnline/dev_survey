namespace :dev_survey do
  namespace :users do
    desc "create in bulk with from csv"
    task :generate => :environment
    task :create, [:prefix, :number] do |t, filename|
      abort invalid_args_message unless args.filename
      abort invalid_file_message unless correct_file_type?(args.filename)
      UserCreator.new(args).create!
    end
  end
end

private

def correct_file_type?(filename)
  filename[-4,4] == '.csv'
end

def invalid_args_message
  "Usage: rake dev_survey:tokens:generate[filename]"
end

def invalid_file_message
  "requires a csv file"
end
