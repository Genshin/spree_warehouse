require 'rake'
require 'rake/testtask'
require 'rake/packagetask'
require 'rubygems/package_task'
require 'rspec/core/rake_task'
require 'spree/core/testing_support/common_rake'

RSpec::Core::RakeTask.new


task :all_tests do
  ["rake spec", "cucumber" ].each do |cmd|
    puts "Starting to run #{cmd}..."
    #system("export DISPLAY=:99.0 && bundle exec #{cmd}")
    system("bundle exec #{cmd}")
    raise "#{cmd} failed!" unless $?.exitstatus == 0
  end
end




task :default => [:all_tests]

spec = eval(File.read('spree_warehouse.gemspec'))

Gem::PackageTask.new(spec) do |p|
  p.gem_spec = spec
end


desc "Release to gemcutter"
task :release => :package do
  require 'rake/gemcutter'
  Rake::Gemcutter::Tasks.new(spec).define
  Rake::Task['gem:push'].invoke
end

desc "Generates a dummy app for testing"
task :test_app do
  ENV['LIB_NAME'] = 'spree_warehouse'
  Rake::Task['common:test_app'].invoke
end
