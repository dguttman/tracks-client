require File.expand_path(File.join(File.dirname(__FILE__), '../spec_helper'))

include Tracks

describe Todo do
  
  before do
    @client = Client.new
  end
  
  it "should have the same data as its remote todo" do
    @todos = @client.todos
    @todos.each do |local_todo|
      remote_todo = local_todo.remote_todo
      local_todo.description.should == remote_todo.description
    end
  end
  
end

describe RemoteTodo do
  
  before do
    @client = Client.new
  end
  
  it "should create a remote todo from local" do
    @context = Context.find(:first)
    @todo = @context.todos.create(:description => "this is a test todo")
    @remote_todo = @todo.sync_to_remote
    @remote_todo.reload
    p @remote_todo
    found_remote_todo = RemoteTodo.find(@remote_todo.id)
    @remote_todo.should == found_remote_todo
    @todo.destroy
    @remote_todo.destroy
  end
  
end