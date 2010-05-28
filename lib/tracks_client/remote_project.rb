module Tracks
  
  class RemoteProject < RemoteBase
    self.element_name = "project"
    
    def todos
      return attributes["todos"] if attributes.keys.include?("todos")
      return RemoteTodo.find(:all, :params => {:project_id => id})
    end
  end
  
end