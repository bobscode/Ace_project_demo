set :rake, "#{rake} --trace"

# $:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.
# $LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'deploy')
#require "capistrano_database"
# require "rvm/capistrano"
require "bundler/capistrano"
load 'deploy/assets' # only for rails 3.1 apps, this makes sure our assets are precompiled.


default_run_options[:pty] = true  # Must be set for the password prompt from git to work
ssh_options[:forward_agent] = true
set :branch, "master"
set :deploy_via, :remote_cache

set :application, "AdvantageApps"
set :repository,  "git@github.com:"
set :scm, :git
set :user, "advantage"

#set :rvm_ruby_string, 'ruby-1.9.2-p180'
#set :rvm_type, :user  
set :deploy_to, "/opt/Advantage/AdvantageApps"
set :use_sudo, false
set :rails_env, 'production'

role :web, "174.129.242.165"                          # Your HTTP server, Apache/etc

namespace :deploy do
  # Invoked after each deployment afterwards
  desc "tell passenger to restart processes"
  task :restart do
    run "cd #{current_path} && touch tmp/restart.txt"
  end
end

