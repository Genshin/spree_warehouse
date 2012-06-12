require 'capistrano_colors'

default_run_options[:pty] = true

server "freestyle.kuroi.net:5466", :app, :web, :db, :primary => true

set :application, "spree_warehouse"
set :repository,  "git@github.com:Genshin/spree_warehouse.git"

set :scm, :git
set :branch, "master"

set :user, "freestyle"
set :deploy_to, "/home/freestyle/FreeStyle"

set :use_sudo, false

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

capistrano_color_matchers = [
  { :match => /command finished/,       :color => :hide,      :prio => 10 },
  { :match => /executing command/,      :color => :blue,      :prio => 10, :attribute => :underscore },
  { :match => /^transaction: commit$/,  :color => :magenta,   :prio => 10, :attribute => :blink },
  { :match => /git/,                    :color => :white,     :prio => 20, :attribute => :reverse },
]

colorize( capistrano_color_matchers )


# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"