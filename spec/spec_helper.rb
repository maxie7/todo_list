require 'capybara/rspec'
require 'cancan/matchers'
require 'capybara/poltergeist'
require 'shoulda-matchers'

RSpec.configure do |config|
  config.include Capybara::DSL

  Capybara.javascript_driver = :poltergeist

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do |example|
    DatabaseCleaner.strategy = example.metadata[:js] ? :truncation : :transaction
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  # config.include FactoryGirl::Syntax::Methods

end

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

include ActionDispatch::TestProcess
include Warden::Test::Helpers

OmniAuth.config.mock_auth[:facebook] = {
    'info' => {
        'name' => Faker::Name.name,
        'email' => Faker::Internet.email,
        'image' => '', },
    'uid' => '123545',
    'provider' => 'facebook',
    'credentials' => {'token' => 'token'}
}
