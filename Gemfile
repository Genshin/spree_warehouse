source 'http://rubygems.org'

gem 'devise', '1.4.8'
gem 'sqlite3'
gem 'rails', '>= 3.1.1', '<= 3.1.3'
gem 'spree', '~>1.0.0' 

#gem 'spree', :git => 'git://github.com/spree/spree.git', :branch => "1-0-stable

group :development, :test do 
  gem "sass", :require => 'sass'
end


group :test do
  gem 'rspec-rails', '~> 2.8.0'
  gem 'factory_girl_rails', '~> 1.7.0'
  gem 'cucumber-rails'
  gem 'ffaker'
  gem 'shoulda-matchers', '~> 1.0.0'
  gem 'capybara'
  gem 'selenium-webdriver','~> 2.20.0'
  gem 'database_cleaner', '0.7.1'
  gem 'launchy'
  
  
  gem 'guard'
  gem 'guard-rspec', '~> 0.6.0'
  gem 'guard-cucumber'
  gem 'guard-bundler'
  
  #desktop notifications
  gem 'rb-fsevent', :require => RUBY_PLATFORM.include?('darwin')  && 'rb-fsevent'
  gem 'growl',      :require => RUBY_PLATFORM.include?('darwin')  && 'growl'
  gem 'rb-inotify', :require => RUBY_PLATFORM.include?('linux')   && 'rb-inotify'
  gem 'libnotify',  :require => RUBY_PLATFORM.include?('linux')   && 'rb-inotify'

  platform :ruby_18 do
    gem 'rcov'
  end
  platform :ruby_19 do
    gem 'simplecov'
  end

end

platform :ruby_18 do
  gem 'ruby-debug'
end

platform :ruby_19 do
  gem 'ruby-debug19'
end

gemspec