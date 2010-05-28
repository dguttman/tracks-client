require File.expand_path(File.join(File.dirname(__FILE__), '../spec_helper'))

include Tracks

describe Context do
  
  before do
    @client = Client.new
  end
  
  it "should have the same data as its remote context" do
    @contexts = @client.contexts
    @contexts.each do |local_context|
      remote_context = local_context.remote
      local_context.name.should == remote_context.name
    end
  end
  
  it "should create a remote context from local" do
    @context = Context.create(:name => "TestContext")
    @remote_context = @context.sync_to_remote
    
    found_remote_context = RemoteContext.find(@remote_context.id)
    @remote_context.should == found_remote_context
    @context.destroy
    @remote_context.destroy
  end
  
end