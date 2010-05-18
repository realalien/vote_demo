# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require 'tasks/rails'


desc "Add the default roles(admin, leader, employee)"
task :user_role_init => :environment do
#  Role.create( :name => 'admin' )
#  Role.create( :name => 'leader' )
#  Role.create( :name => 'employee' )
#  
#  User.create( :name => "Admin" , 
#               :login => "admin" , 
#               :email => "ZhuJiaCheng@spicyhorse.com", 
#               :password => "123456",
#               :password_confirmation => "123456")
#  
#  User.create( :name => "Guest" , 
#               :login => "guest" , 
#               :email => "guest@spicyhorse.com", 
#               :password => "123456",
#               :password_confirmation => "123456")
               
  r = Role.find_by_name("admin")
  u = User.find_by_login("zhujiacheng2")
  if r and u
    u.roles << r
    u.save!
  end
  
  
end

