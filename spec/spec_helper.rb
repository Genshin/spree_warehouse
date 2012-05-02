# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)

require 'rspec/rails'
#require 'capybara/rspec'

require 'database_cleaner'
require 'spree/core/url_helpers'
require 'spree/core/testing_support/factories'
require 'spree/core/testing_support/env'

require 'spree/api/testing_support/helpers'
require 'spree/api/testing_support/setup'

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
  
  config.include Spree::Core::UrlHelpers
  config.include Spree::Api::TestingSupport::Helpers, :type => :controller
  config.extend Spree::Api::TestingSupport::Setup, :type => :controller

  config.include Devise::TestHelpers, :type => :controller
  config.include SpreeWarehouse::Engine.routes.url_helpers
  config.include Rack::Test::Methods, :type => :requests

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false
end


shared_context "product prototype" do
  
  def build_option_type_with_values(name, values)
    ot = Factory(:option_type, :name => name)
    values.each do |val|
      ot.option_values.create(:name => val.downcase, :presentation => val)
    end
    ot
  end
  
  let(:product_attributes) do
    # Factory.attributes_for is un-deprecated!
    #   https://github.com/thoughtbot/factory_girl/issues/274#issuecomment-3592054
    Factory.attributes_for(:simple_product)
  end

  let(:prototype) do
    size = build_option_type_with_values("size", %w(Small Medium Large))
    Factory(:prototype, :name => "Size", :option_types => [ size ])
  end
  
  let(:option_values_hash) do
    hash = {}
    prototype.option_types.each do |i|
      hash[i.id.to_s] = i.option_value_ids
    end
    hash
  end
  
end  


PAYMENT_STATES = Spree::Payment.state_machine.states.keys unless defined? PAYMENT_STATES
SHIPMENT_STATES = Spree::Shipment.state_machine.states.keys unless defined? SHIPMENT_STATES
ORDER_STATES = Spree::Order.state_machine.states.keys unless defined? ORDER_STATES

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