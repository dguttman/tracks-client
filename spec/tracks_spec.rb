require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe Tracks::Client do
  
  before do
    @client = Tracks::Client.new 
  end
  
  it "creates a client" do
    @client.class.should == Tracks::Client
  end

  it "shows remote todos" do
    remote_todos = @client.remote_todos
    remote_todos.class.should == Array
  end
  
  it "shows remote contexts" do
    remote_contexts = @client.remote_contexts
    remote_contexts.class.should == Array
  end
  
  it "shows remote projects" do
    remote_projects = @client.remote_projects
    remote_projects.class.should == Array
  end
  
  it "syncs todos to local" do
    @client.sync_todos_to_local
  end
  
  it "syncs contexts to local" do
    @client.sync_contexts_to_local
  end

  it "syncs projects to local" do
    @client.sync_projects_to_local
  end

  it "processes remote queue" do
    @client.sync_to_local
    @client.process_remote_queue
  end

end