require File.expand_path(File.join(File.dirname(__FILE__), '../spec_helper'))

include Tracks

describe Project do
  
  before do
    @client = Client.new
  end
  
  it "should have the same data as its remote project" do
    @projects = @client.projects
    @projects.each do |local_project|
      remote_project = local_project.remote
      local_project.name.should == remote_project.name
    end
  end
  
  it "should create a remote project from local" do
    @project = Project.create(:name => "TestProject")
    @remote_project = @project.sync_to_remote
    
    found_remote_project = RemoteProject.find(@remote_project.id)
    @remote_project.should == found_remote_project
    @project.destroy
    @remote_project.destroy
  end
  
end