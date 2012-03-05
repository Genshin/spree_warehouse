source 'http://rubygems.org'

gem 'devise', '1.4.8'
gem 'sqlite3'
gem 'rails', '>= 3.1.1', '<= 3.1.3'
gem 'spree', "~>1.0.0" 

#gem 'spree', :git => 'git://github.com/spree/spree.git', :branch => "1-0-stable


group :development , :test do 
  gem 'guard'
  gem 'guard-livereload'
  gem 'guard-bundler'
  gem 'libnotify'
  #gem 'rack-livereload'
  #optimisation for livereload
  gem 'yajl-ruby' 
end


group :test do
  gem 'guard-rspec', '~> 0.6.0'
  gem 'guard-cucumber'
  
  gem 'rspec-rails', '~> 2.8.0'
  gem 'factory_girl_rails', '~> 1.6.0'
  gem 'cucumber-rails'
  gem 'ffaker'
  gem 'shoulda-matchers', '~> 1.0.0'
  gem 'capybara'
  gem 'selenium-webdriver', '~> 2.18.0'
  gem 'database_cleaner', '0.7.1'
  gem 'launchy'

  platform :ruby_18 do
    gem 'rcov'
  end
  platform :ruby_19 do
    gem 'simplecov'
  end

end

platform :ruby_18 do
  gem "ruby-debug"
end

platform :ruby_19 do
  gem "ruby-debug19"
end

gemspec