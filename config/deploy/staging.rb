set :user, "ec2-user"
server "ec2-54-193-10-98.us-west-1.compute.amazonaws.com", :app, :web, :db, :primary => true
ssh_options[:keys] = ["~/.ssh/testapp.pem"]