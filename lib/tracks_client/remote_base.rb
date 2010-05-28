module Tracks
  
  # TODO: Put these into the context, project, todo model files
  class RemoteBase < ActiveResource::Base
    
    def ar_attributes
      ar_attributes = attributes.merge({"remote_id" => self.id})
      
      ar_attributes.delete("id")
      ar_attributes.delete("created_at")
      ar_attributes.delete("updated_at")
      ar_attributes
    end
    
    def destroy
      self.class.delete(self.id)
    end
    
  end
  
end