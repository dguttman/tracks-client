require File.expand_path(File.join(File.dirname(__FILE__), '../spec_helper'))

describe Tracks::Todo do
  
  before do
    @client = Tracks::Client.new
  end
  
  it "should have the same data as its remote todo" do
    @todo = @client.todos.first
    @remote_todo = @todo.remote_todo
    @todo.description.should == @remote_todo.description
  end
  
end