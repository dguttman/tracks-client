require 'rubygems'
require 'active_record'
require 'yaml'


Dir["lib/*.rb"].each {|file| require file }

auth = YAML.load_file(File.join(ENV["HOME"], ".tracks_client"))
username, password = auth["username"], auth["password"]

site = "http://#{username}:#{password}@dgtracks.heroku.com/"

dbconfig = YAML::load(File.open('database.yml'))
ActiveRecord::Base.establish_connection(dbconfig)






client = Tracks::Base.site = site

projects = Project.all
p projects

# context = Tracks::RemoteContext.find(:first)
# todo = Tracks::RemoteTodo.find(:first)
remote_projects = Tracks::RemoteProject.find(:all)
p remote_projects

