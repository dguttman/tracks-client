require 'rubygems'
require 'ap'
require 'active_record'
require 'active_resource'
require 'yaml'

load_dir = File.join(File.dirname(__FILE__), 'tracks_client')
Dir["#{load_dir}/*.rb"].each {|file| require file }

module Tracks

  class Client
    
    attr_reader :remote_queue, :local_queue
    
    
    def initialize      
      init_active_resource
      init_active_record
      @remote_queue = []
      @local_queue = []
    end
    
    def remote_todos
      RemoteTodo.find(:all)
    end
    
    def remote_contexts
      RemoteContext.find(:all)
    end
    
    def remote_projects
      RemoteProject.find(:all)
    end
    
    def todos
      Todo.find(:all)
    end
    
    def contexts
      Context.find(:all)
    end
    
    def projects
      Project.find(:all)
    end
    
    def sync_to_local
      sync_contexts_to_local
      sync_projects_to_local
      sync_todos_to_local
    end
    
    def process_remote_queue
      @remote_queue.each do |item|
        p item.class
      end
    end
    
    def sync_to_remote
      sync_contexts_to_remote
      sync_projects_to_remote
      sync_todos_to_remote
    end
    
    def sync_contexts_to_remote
      self.contexts.each do |context|
        context.sync_to_remote
      end
    end
    
    def sync_projects_to_remote
      self.projects.each do |project|
        project.sync_to_remote
      end
    end
    
    def sync_todos_to_remote
      self.todos.each do |todo|
        todo.sync_to_remote
      end
    end

    def sync_contexts_to_local
      @remote_contexts = RemoteContext.find(:all)
      @remote_contexts.each do |remote_context|
        context = Context.new_from_remote(remote_context)
      end
    end
    
    def sync_projects_to_local
      @remote_projects = RemoteProject.find(:all)
      @remote_projects.each do |remote_project|
        project = Project.new_from_remote(remote_project)
      end
    end
    
    def sync_todos_to_local
      @remote_todos = RemoteTodo.find(:all)
      @remote_todos.each do |remote_todo|
        todo = Todo.new_from_remote(remote_todo)
      end      
    end


    
  private
    
    def init_active_resource
      auth = YAML.load_file(File.join(ENV["HOME"], ".tracks_client"))
      username, password = auth["username"], auth["password"]
      site = "http://#{username}:#{password}@dgtracks.heroku.com/"
      Tracks::RemoteBase.site = site
    end
    
    def init_active_record
      dbconfig = YAML::load(File.open('database.yml'))
      ActiveRecord::Base.establish_connection(dbconfig)
      ActiveRecord::Base.logger = Logger.new("log/development.log")
    end

  end
  
end