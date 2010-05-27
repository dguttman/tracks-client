require File.expand_path(File.join(File.dirname(__FILE__), '../spec_helper'))

describe Tracks::Todo do
  
  before do
    @client = Tracks::Client.new
  end
  
  it "should have the same data as its remote todo" do
    @todos = @client.todos
    @todos.each do |local_todo|
      ap local_todo
      remote_todo = local_todo.remote_todo
      ap remote_todo
      local_todo.description.should == remote_todo.description
      puts ""
    end
  end
  
end

# describe Tracks::RemoteTodo do
#   
#   before do
#     @client = Tracks::Client.new
#   end
#   
#   it "should create a remote todo from local" do
#     @context = Tracks::Context.find(:first)
#     @todo = @context.todos.create(:description => "this is a test todo")
#     @remote_todo = Tracks::RemoteTodo.new_from_local(@todo)
#     @remote_todo.reload
#     p @remote_todo
#     found_remote_todo = Tracks::RemoteTodo.find(:first, :params => {:description => @remote_todo.description})
#     @remote_todo.should == found_remote_todo
#   end
#   
# end