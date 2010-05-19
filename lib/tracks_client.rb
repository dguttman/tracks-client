require 'rubygems'
require 'httparty'
require 'ap'

module Tracks

  class Client
    include HTTParty
    base_uri 'http://dgtracks.heroku.com'
  
    def initialize(u, p)
      @auth = {:username => u, :password => p}
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
      @todos = todo_hash["todos"].map {|todo| Tracks::Todo.new(todo)}
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
  
    def get_contexts(options={})
      options.merge!({:basic_auth => @auth})
      context_hash = self.class.get('/contexts.xml', options)
      @contexts = context_hash["contexts"].map {|context| Tracks::Context.new(context)}
    end
  
    def get_context(options={})
      if options.class == Integer
        options = {:id => options}
      end
      
      options.merge!({:basic_auth => @auth})
      self.class.get("/contexts/#{options[:id]}.xml", options)
    end
  
    def get_context_todos(options={})
      def get_context(options={})
        if options.class == Integer
          options = {:id => options}
        end

        options.merge!({:basic_auth => @auth})
        self.class.get("/contexts/#{options[:id]}/todos.xml", options)
      end
    end
  
  
    # Projects
  
    def projects
      if @projects
        return @projects
      else
        @projects = get_projects
      end
    end
  
    def get_projects(options={})
      options.merge!({:basic_auth => @auth})
      project_hash = self.class.get('/projects.xml', options)
      @projects = project_hash["projects"].map {|project| Tracks::Project.new(project)}
    
    end
  
    def get_project(options={})
      if options.class == Integer
        options = {:id => options}
      end
      
      options.merge!({:basic_auth => @auth})
      self.class.get("/projects/#{options[:id]}.xml", options)
    end
  
    def get_project_todos(options={})
      def get_project(options={})
        if options.class == Integer
          options = {:id => options}
        end

        options.merge!({:basic_auth => @auth})
        self.class.get("/projects/#{options[:id]}/todos.xml", options)
      end
    end  
  end
  
end