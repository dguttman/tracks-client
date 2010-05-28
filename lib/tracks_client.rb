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
      p "syncing contexts to local"
      sync_contexts_to_local
      p "syncing projects to local"
      sync_projects_to_local
      p "syncing todos to local"
      sync_todos_to_local
    end
    
    def sync_to_remote
      p "syncing contexts to remote"
      sync_contexts_to_remote
      p "syncing projects to remote"
      sync_projects_to_remote
      p "syncing todos to remote"
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
      p "finding remote contexts"
      @remote_contexts = RemoteContext.find(:all)
      p "creating local contexts from remote"
      @remote_contexts.each do |remote_context|
        p "checking remote_context: #{remote_context.name}"
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
      config = YAML.load_file(File.join(ENV["HOME"], ".tracks_client"))
      username, password, host = config["username"], config["password"], config["host"]
      site = "http://#{username}:#{password}@#{host}/"
      Tracks::RemoteBase.site = site
    end
    
    def init_active_record
      dbconfig = YAML::load(File.open('database.yml'))
      ActiveRecord::Base.establish_connection(dbconfig)
      ActiveRecord::Base.logger = Logger.new("log/database.log")
    end

  end
  
end