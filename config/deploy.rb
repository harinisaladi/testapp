set :stages, ["staging"]
set :default_stage, "staging"
require 'capistrano/ext/multistage'

set :application, "testapp"
set :repository,  "git@github.com:harinisaladi/testapp.git"

# You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :scm, :git 
set :use_sudo, false

set :user, "ec2-user"
set :deploy_to, "/var/www/testapp"
desc "check staging task"

task :check_staging do
  if stage.to_s == "staging"
    puts " \n Are you REALLY sure you want to deploy to staging?"
    puts " \n Enter the password to continue\n "
    password = STDIN.gets[0..7] rescue nil
    if password != 'stagingpassword'
      puts "\n !!! WRONG PASSWORD !!!"
      exit
    end
  end
end

role :web, "ec2-54-193-10-150.us-west-1.compute.amazonaws.com"                          # Your HTTP server, Apache/etc
role :app, "ec2-54-193-10-150.us-west-1.compute.amazonaws.com"                          # This may be the same as your `Web` server
role :db,  "ec2-54-193-10-150.us-west-1.compute.amazonaws.com", :primary => true # This is where Rails migrations will run
#role :db,  "ec2-54-193-10-98.us-west-1.compute.amazonaws.com"

before "deploy", "check_staging"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end