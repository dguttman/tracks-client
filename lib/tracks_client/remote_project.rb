require File.join(File.dirname(__FILE__), 'remote_base')

module Tracks
  
  class RemoteProject < RemoteBase
    self.element_name = "project"
    
    def todos
      return attributes["todos"] if attributes.keys.include?("todos")
      return RemoteTodo.find(:all, :params => {:project_id => id})
    end
  end
  
end