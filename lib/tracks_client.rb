require 'rubygems'
require 'ap'
require 'active_record'
require 'active_resource'
require 'yaml'

Dir["tracks_client/*.rb"].each {|file| require file }


module Tracks

  class Client
    
    attr_reader :remote_todos, :remote_contexts, :remote_projects
    
    def initialize      
      init_active_resource
      init_active_record
    end
    
    def sync_to_local
      sync_todos_to_local
      # sync_contexts_to_local
    end
    
    def sync_todos_to_local
      @remote_todos = RemoteTodo.find(:all)
      @remote_todos.each do |remote_todo|
        Todo.create(remote_todo.ar_attributes)
      end      
    end

    def sync_contexts_to_local
      @remote_contexts = RemoteContext.find(:all)
      @remote_contexts.each do |remote_context|
        Context.create(remote_context.ar_attributes)
      end
    end
    
  private
    
    def init_active_resource
      auth = YAML.load_file(File.join(ENV["HOME"], ".tracks_client"))
      username, password = auth["username"], auth["password"]
      site = "http://#{username}:#{password}@dgtracks.heroku.com/"
      Tracks::Base.site = site
    end
    
    def init_active_record
      dbconfig = YAML::load(File.open('database.yml'))
      ActiveRecord::Base.establish_connection(dbconfig)
      ActiveRecord::Base.logger = Logger.new(STDOUT)
    end

  end
  
end