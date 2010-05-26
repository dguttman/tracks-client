module Tracks
  class Todo < ActiveRecord::Base

    validates_uniqueness_of :remote_todo_id
    
    def self.new_from_remote(remote_todo)
      existing_todo = self.find_by_remote_todo_id(remote_todo.id)
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
      RemoteTodo.find(:first, :params => {:id => self.remote_todo_id})
    end
    
    def project
      Project.find_by_remote_project_id(self.remote_project_id)
    end
    
    def context
      Context.find_by_remote_context_id(self.remote_context_id)
    end
    
  end
  

  
end