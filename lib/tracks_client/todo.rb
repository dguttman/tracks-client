module Tracks
  class Todo < Base
    
    belongs_to :project
    belongs_to :context
      
    def self.create_new_with_remote(remote)      
      local_context = Context.find_by_remote_id(remote.context_id)
      local_project = Project.find_by_remote_id(remote.project_id)
      local = self.new( remote.ar_attributes.merge( {:project_id => local_project.id, :context_id => local_context.id} ) )
      local.synced_at = Time.now
      return local.save    
    end
    
    def remote_class
      RemoteTodo
    end
    
    def remote_project_id
      return self.project.remote_id if self.project
    end
    
    def remote_context_id
      return self.context.remote_id if self.context
    end
    
    def ar_attributes
      ar_attributes = super
      ar_attributes.merge!( { "project_id" => self.remote_project_id, "context_id" => self.remote_context_id } )
      ar_attributes
    end
    
  end
  

  
end