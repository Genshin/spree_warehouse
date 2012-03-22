# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)

require 'rspec/rails'
#require 'capybara/rspec'

require 'database_cleaner'
require 'spree/url_helpers'
require 'spree/core/testing_support/factories'
require 'spree/core/testing_support/env'
require 'active_record/fixtures'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}


# include local factories
Dir["#{File.dirname(__FILE__)}/factories/**/*.rb"].each { |f| require File.expand_path(f)}


#fixtures_dir = File.expand_path('../../../core/db/default', __FILE__)
#ActiveRecord::Fixtures.create_fixtures(fixtures_dir, ['spree/roles'])


RSpec.configure do |config|

  config.mock_with :rspec
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  
  config.before(:each) do
    if example.metadata[:js]
      DatabaseCleaner.strategy = :truncation, { :except => ['spree_countries', 'spree_zones', 'spree_zone_members', 'spree_states', 'spree_roles'] }
    else
      DatabaseCleaner.strategy = :transaction
    end
  end


  config.before(:each) do
    DatabaseCleaner.start
    reset_spree_preferences
  end

  config.after(:each) do
    DatabaseCleaner.clean
    Spree::Ability.abilities.delete(AbilityDecorator) if Spree::Ability.abilities.include?(AbilityDecorator)
  end
  
  config.include Spree::UrlHelpers
  config.include Devise::TestHelpers, :type => :controller
  config.include SpreeWarehouse::Engine.routes.url_helpers
  config.include Rack::Test::Methods, :type => :requests

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false
end

if defined? CanCan::Ability
  class AbilityDecorator
    include CanCan::Ability

    def initialize(user)
      cannot :manage, Spree::Order
    end
  end
end

RSpec::Matchers.define :have_valid_factory do |factory_name|
  match do |model|
    Factory(factory_name).new_record?.should be_false
  end
end


#Capybara.default_driver = :selenium