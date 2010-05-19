require 'rubygems'
require 'httparty'
require 'ap'
require 'ostruct'
OpenStruct.__send__(:define_method, :id) { @table[:id] || self.object_id }

module Tracks

  class Client
    include HTTParty
    
    base_uri 'http://dgtracks.heroku.com'
    
    attr_reader :cache_time
    
    def initialize(u, p)
      @auth = {:username => u, :password => p}
      @cache_time = {}
    end
    
    def refresh_all
      get_todos
      get_contexts
      get_projects
    end
    
    # Todos
  
    def todos
      if @todos
        return @todos
      else
        @todos = get_todos
      end
    end
  
    def get_todos(options={})
      options.merge!({:basic_auth => @auth})
      todo_hash = self.class.get('/todos.xml', options)
      @cache_time[:todos] = Time.now if todo_hash
      @todos = todo_hash["todos"].map {|todo| Tracks::Todo.new(self, todo)}
    end
  
    def get_todo(options={})
      if options.class == Integer
        options = {:id => options}
      end
      
      options.merge!({:basic_auth => @auth})
      self.class.get("/todos/#{options[:id]}.xml", options)
    end
  
    # Contexts
  
    def contexts
      if @contexts
        return @contexts
      else
        @contexts = get_contexts
      end
    end
    
    def context_todos(id)
      @context_todos ||= []
      if @context_todos[id]
        return @context_todos[id]
      else
        @context_todos[id] = get_context_todos(id)
      end
    end
  
    def get_contexts(options={})
      options.merge!({:basic_auth => @auth})
      context_hash = self.class.get('/contexts.xml', options)
      @cache_time[:contexts] = Time.now if context_hash
      @contexts = context_hash["contexts"].map {|context| Tracks::Context.new(self, context)}
    end
  
    def get_context(options={})
      if options.class == Integer
        options = {:id => options}
      end
      
      options.merge!({:basic_auth => @auth})
      self.class.get("/contexts/#{options[:id]}.xml", options)
    end
  
    def get_context_todos(id)
      context_todos = todos.select {|todo| todo.context_id == id}
    end
  
  
    # Projects
  
    def projects
      if @projects
        return @projects
      else
        @projects = get_projects
      end
    end
    
    def project_todos(id)
      @project_todos ||= []
      if @project_todos[id]
        return @project_todos[id]
      else
        @project_todos[id] = get_project_todos(id)
      end
    end
  
    def get_projects(options={})
      options.merge!({:basic_auth => @auth})
      project_hash = self.class.get('/projects.xml', options)
      @cache_time[:projects] = Time.now if project_hash
      @projects = project_hash["projects"].map {|project| Tracks::Project.new(self, project)}
    end
  
    def get_project(options={})
      if options.class == Integer
        options = {:id => options}
      end
      
      options.merge!({:basic_auth => @auth})
      self.class.get("/projects/#{options[:id]}.xml", options)
    end
  
    def get_project_todos(id)
      project_todos = todos.select {|todo| todo.project_id == id}
    end
    
  end
  
end