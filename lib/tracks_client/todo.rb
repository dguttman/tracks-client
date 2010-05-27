module Tracks
  class Todo < ActiveRecord::Base

    validates_uniqueness_of :remote_id
    
    belongs_to :project
    belongs_to :context
    
    def self.new_from_remote(remote_todo)
      existing_todo = self.find_by_remote_id(remote_todo.id)
      if existing_todo
        existing_time = existing_todo.updated_at
        remote_time = remote_todo.updated_at
        if existing_time < remote_time
          existing_todo.update_attributes(remote_todo.ar_attributes)
          return existing_todo
        end
      else
        todo = self.new(remote_todo.ar_attributes)
        return todo.save
      end
    end
    
    def remote_todo
      if self.remote_id
        RemoteTodo.find(:all, :params => {:id => self.remote_id}).first
      end
    end
    
    def project
      Project.find_by_remote_id(self.remote_project_id)
    end
    
    def context
      Context.find_by_remote_id(self.remote_context_id)
    end
    
    def ar_attributes
      ar_attributes = attributes.merge({:project_id => "remote_project_id", :context_id => "remote_context_id"})
      
      ar_attributes.delete("id")
      ar_attributes.delete("remote_id")
      ar_attributes.delete("remote_project_id")
      ar_attributes.delete("remote_context_id")
      ar_attributes.delete("created_at")
      ar_attributes.delete("updated_at")
      ar_attributes
    end
    
  end
  

  
end