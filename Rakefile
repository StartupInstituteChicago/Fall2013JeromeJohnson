# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

ReserveMe::Application.load_tasks

require 'dotenv/tasks'

task :mytask => :dotenv do
    # things that require .env
end
