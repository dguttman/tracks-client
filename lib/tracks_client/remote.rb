module Tracks
  
  # TODO: Put these into the context, project, todo model files
  class RemoteBase < ActiveResource::Base
    
    def ar_attributes
      ar_attributes = attributes.merge({"remote_#{self.class.element_name}_id" => self.id})
      
      ar_attributes.delete("id")
      ar_attributes.delete("created_at")
      ar_attributes.delete("updated_at")
      ar_attributes
    end    
    
  end

  class RemoteTodo < RemoteBase
    self.element_name = "todo"
    
    def ar_attributes
      ar_attributes = super
      ar_attributes["remote_project_id"] = attributes["project_id"]
      ar_attributes.delete("project_id")
      ar_attributes["remote_context_id"] = attributes["context_id"]
      ar_attributes.delete("context_id")
      ar_attributes
    end
  end

  class RemoteContext < RemoteBase
    self.element_name = "context"
    
    def todos
      return attributes["todos"] if attributes.keys.include?("todos")
      return RemoteTodo.find(:all, :params => {:context_id => id})
    end
  end
  
  class RemoteProject < RemoteBase
    self.element_name = "project"
    
    def todos
      return attributes["todos"] if attributes.keys.include?("todos")
      return RemoteTodo.find(:all, :params => {:project_id => id})
    end
  end

end