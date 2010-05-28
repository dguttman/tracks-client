require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

include Tracks

describe Client do
  
  before do
    @client = Client.new 
  end
  
  it "creates a client" do
    @client.class.should == Client
  end

  it "shows remote todos, contexts, projects" do
    remote_todos = @client.remote_todos
    remote_todos.class.should == Array

    remote_contexts = @client.remote_contexts
    remote_contexts.class.should == Array

    remote_projects = @client.remote_projects
    remote_projects.class.should == Array
  end
  
  it "syncs to remote" do
    @client.sync_to_remote
  end
  
  it "syncs contexts to remote" do
    @client.sync_contexts_to_remote
  end

  it "syncs projects to remote" do
    @client.sync_projects_to_remote
  end
  
  it "syncs todos to remote" do
    @client.sync_todos_to_remote
  end
  
  it "syncs contexts to local" do
    @client.sync_contexts_to_local
  end

  it "syncs projects to local" do
    @client.sync_projects_to_local
  end
  
  it "syncs todos to local" do
    @client.sync_todos_to_local
  end
  
  it "shows local todos, contexts, and projects" do
    todos = @client.todos
    todos.class.should == Array
    
    contexts = @client.contexts
    contexts.class.should == Array
    
    projects = @client.projects
    projects.class.should == Array
  end
  
end