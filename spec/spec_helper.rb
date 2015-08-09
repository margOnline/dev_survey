if ENV["COV"]
  require 'simplecov'
  SimpleCov.start 'rails'
end

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'rspec/rails'
require 'shoulda/matchers'
require 'capybara/poltergeist'
require 'capybara-screenshot/rspec'
require 'shoulda/matchers'
require 'sidekiq/testing'

Capybara.javascript_driver = :poltergeist
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, {js_errors: false})
end

Sidekiq::Testing.fake!

ActiveRecord::Migration.maintain_test_schema! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.render_views = true

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  config.profile_examples = 10

  config.order = :random

  Kernel.srand config.seed

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end
  config.mock_with :flexmock


  config.infer_spec_type_from_file_location!
end

class ActiveRecord::Base
  mattr_accessor :shared_connection
  @@shared_connection = nil

  def self.connection
    @@shared_connection || ConnectionPool::Wrapper.new(size: 1) do
      retrieve_connection
    end
  end
end
