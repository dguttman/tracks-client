require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe Tracks::Client do
  it "creates a client" do
    client = Tracks::Client.new
    client.class.should == Client
  end

  it "shows remote todos"




  # p Tracks::Todo.all
  # 
  # client.sync_to_local

end