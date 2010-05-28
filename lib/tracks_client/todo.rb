module Tracks
  class Todo < ActiveRecord::Base

    validates_uniqueness_of :remote_id
    
    belongs_to :project
    belongs_to :context
    
    def self.new_from_remote(remote_todo)
      existing_todo = self.find_by_remote_id(remote_todo.id)
      if existing_todo
        synced_time = existing_todo.synced_at
        modified_time = existing_todo.updated_at
        remote_time = remote_todo.updated_at
        if synced_time < remote_time && modified_time < remote_time
          existing_todo.update_attributes(remote_todo.ar_attributes)
          existing_todo.synced_at = Time.now
          return existing_todo
        end
      else
        local_context = Context.find_by_remote_id(remote_todo.context_id)
        local_project = Project.find_by_remote_id(remote_todo.project_id)
        todo = self.new(remote_todo.ar_attributes.merge({:project_id => local_project.id, :context_id => local_context.id}))
        todo.synced_at = Time.now
        return todo.save
      end
    end
    
    def sync_to_remote
      existing_todo = remote_todo
      if existing_todo
        existing_time = existing_todo.updated_at
        if existing_time < self.updated_at && self.updated_at != self.created_at
          remote_todo.attributes = self.ar_attributes
          remote_todo.save
        end
      else
        remote_todo = RemoteTodo.new(self.ar_attributes)
        if remote_todo.save
          remote_todo.reload
          self.remote_id = remote_todo.id
          return remote_todo
        end
      end
    end
    
    def remote_todo
      if self.remote_id
        RemoteTodo.find(self.remote_id)
      end
    end
    
    def remote_project_id
      return self.project.remote_id if self.project
    end
    
    def remote_context_id
      return self.context.remote_id if self.context
    end
    
    def ar_attributes
      
      ar_attributes = attributes.merge( { "project_id" => self.remote_project_id, "context_id" => self.remote_context_id } )
      
      ar_attributes.delete("id")
      ar_attributes.delete("remote_id")
      ar_attributes.delete("remote_project_id")
      ar_attributes.delete("remote_context_id")
      ar_attributes.delete("created_at")
      ar_attributes.delete("updated_at")
      ar_attributes.delete("synced_at")
      ar_attributes.delete_if { |k,v| v.nil? }
      ap ar_attributes
      
      ar_attributes
    end
    
  end
  

  
end