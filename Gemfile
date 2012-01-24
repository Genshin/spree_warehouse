source 'http://rubygems.org'

gem 'devise' , '1.4.8'
gem 'rails' , '3.1.3'
gem 'spree', :git => 'git://github.com/spree/spree.git'
gem 'sqlite3'

group :test do
  gem 'guard'
  gem 'guard-rspec', '~> 0.5.0'
  gem 'rspec-rails', '~> 2.8.0'
  gem 'factory_girl_rails', '~> 1.6.0'
  gem 'cucumber-rails'
  gem 'ffaker'
  gem 'shoulda-matchers', '~> 1.0.0'
  gem 'capybara'
  gem 'selenium-webdriver', '2.16.0'
  gem 'database_cleaner', '0.7.1'
  gem 'launchy'
end

if RUBY_VERSION < "1.9"
  gem "ruby-debug"
else
  gem "ruby-debug19"
end

gemspec
